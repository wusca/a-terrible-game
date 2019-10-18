extends Node2D

var default_player_position = Vector2(0, 0)

func _ready():
	#Calls startup functions
	default_player_position = get_node("Player").position
	get_node("Death Area").connect("body_entered", self, "death")
	get_node("Purpose").connect("body_entered", self, "finish")


func respawn(body):
	#Respawns a player
	get_node("Player").position = default_player_position
	get_node("Player").show()


func death(body):
	#Kills the player
	get_node("Player").death()

func finish(body):
	#Finish the level
	get_tree().quit()