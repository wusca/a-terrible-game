extends KinematicBody2D

const UP = Vector2(0, -1)
const gravity = 30

var velocity = Vector2(0, 0)

var jump_height = 500
var speed = 12
var can_double_jump = true

func _physics_process(delta):
	handleInput()
	runPhysics()

#input
func handleInput():
	if (Input.is_action_pressed("move_left")):
		velocity.x -= speed
	if (Input.is_action_pressed("move_right")):
		velocity.x += speed
		
	if (Input.is_action_just_pressed("jump")):
		if (is_on_floor()):
			velocity.y -= jump_height
		else:
			if (can_double_jump):
				velocity.y -=jump_height
				can_double_jump = false


# Physics stuff
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

func runPhysics():
	gravity()
	velocity = move_and_slide(velocity, UP)
	decel()

