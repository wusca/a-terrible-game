extends KinematicBody2D

var velocity = Vector2(0, 0)

func _process(delta):
	handle_input()
	run_physics()

#input
func handle_input():
	if (Input.is_action_pressed("move_left")):
		velocity.x -= 5
	if (Input.is_action_pressed("move_right")):
		velocity.x += 5
		
	if (Input.is_action_just_released("jump")):
		velocity.y -= 64


# Physics stuff
func gravity():
	velocity.y += 2
	pass

func decel():
	#slow me down, chappi
	velocity *= 0.99

func run_physics():
	gravity()
	move_and_slide(velocity)
	decel()
	pass

