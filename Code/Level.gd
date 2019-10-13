extends Node2D

var default_player_position = Vector2(0, 0)

func _ready():
	#Calls startup functions
	default_player_position = get_node("Player").position
	get_node("Death Area").connect("body_exited", self, "respawn")


func respawn(body):
	#Respawns a player
	get_node("Player").position = default_player_position
