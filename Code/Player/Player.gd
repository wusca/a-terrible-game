extends KinematicBody2D

const UP = Vector2(0, -1)
const gravity = 30

var velocity = Vector2(0, 0)

var jump_height = 500
var double_jump_height = 600
var speed = 12
var can_double_jump = true

func _physics_process(delta):
	#Calls functions that need to be synchronized with physics engine
	handle_input()
	run_physics()


func handle_input():
	#Handles input flags and calls corresponding functions
	if (Input.is_action_pressed("move_left")):
		velocity.x -= speed

	if (Input.is_action_pressed("move_right")):
		velocity.x += speed
		
	if (Input.is_action_just_pressed("jump")):
		if (is_on_floor()):
			velocity.y -= jump_height
		else:
			if (can_double_jump):
				velocity.y -= double_jump_height
				can_double_jump = false

# Physics stuff
func run_physics():
	#General physics call
	gravity()
	velocity = move_and_slide(velocity, UP)
	decel()


func gravity():
#	if (!is_on_floor()):
	velocity.y += gravity
	if (is_on_floor()):
		can_double_jump = true


func decel():
	#slow me down, chappi
	if (is_on_floor()):
		#velocity.y = 0
		velocity.x *= .95
	else:
		velocity *= 0.99


func death():
	#Kills the player
	spawn_blood()
	self.hide()
	QuickTimer.create_timer(get_parent(),"respawn",[self],0.4)
	#get_parent().respawn(self)



var blood_res=preload("res://Classes/Effects/DeathExplosion.tscn")
func spawn_blood():
	#spawns in a blood particle
	var inst=blood_res.instance()
	get_parent().add_child(inst)
	inst.position=self.position
	