extends KinematicBody2D

var velocity = Vector2(0, 0)

func _process(delta):
	handleInput()
	runPhysics()

#input
func handleInput():
	if (Input.is_action_pressed("move_left")):
		velocity.x -= 5
	if (Input.is_action_pressed("move_right")):
		velocity.x += 5
		
	if (Input.is_action_just_pressed("jump")):
		velocity.y -= 200


# Physics stuff
func gravity():
	velocity.y += 2
	pass

func decel():
	#slow me down, chappi
	velocity *= 0.99

func runPhysics():
	gravity()
	move_and_slide(velocity)
	decel()
	pass

