extends Node

var music_player
var sound_player



var master_volume=100
var sfx_volume=100
var music_volume=100

var music_volume_db=0
var sfx_volume_db=0

#func sync_volumes():
#	master_volume=Settings.settings["master_volume"]
#	sfx_volume=Settings.settings["sfx_volume"]
#	music_volume=Settings.settings["music_volume"]

func set_master_volume(percentage):
	master_volume=percentage
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -60+((percentage/100)*60))
func set_sfx_volume(percentage):
	if(!sound_player):
		QuickTimer.create_timer(self,"set_sfx_volume",[percentage],0.01)
	else:
		sfx_volume=percentage
		sfx_volume_db=-60+((percentage/100)*60)
		sound_player.volume_db=float(sfx_volume_db)
func set_music_volume(percentage):
	if(!music_player):
		QuickTimer.create_timer(self,"set_music_volume",[percentage],0.01)
	else:
		music_volume=percentage
		music_volume_db=-60+((percentage/100)*60)
		music_player.volume_db=float(music_volume_db)
#		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -60+((percentage/100)*60))

func _ready():
	music_player=AudioStreamPlayer.new()
	music_player.volume_db=-60
	music_player.bus="Music"
	sound_player=AudioStreamPlayer.new()
#	sound_player.connect("finished",self,"custom_oneshot",[sound_player])
	add_child(music_player)
	add_child(sound_player)
	pause_mode=Node.PAUSE_MODE_PROCESS
	#sync_volumes()
	
	


var current_music=null
func play_music(file_name,file_type=".ogg"):
	if(current_music==file_name):return
	#var music_vol=Settings.get_setting("music_volume")
	#set_music_volume(music_vol)
	var ref=load("res://Imported/Music/"+file_name+file_type)
	current_music=file_name
	if(music_player.playing==true):
	#	music_player.stop()
#		Animate.animate(music_player,"volume_db",-60,1)
		QuickTimer.create_timer(self,"execute_play_music",[ref],1.05)
	else:
		execute_play_music(ref)

func execute_play_music(ref):
	if(music_player.playing==true):
		music_player.stop()
#	Animate.animate(music_player,"volume_db",music_volume_db,1)
	music_player.stream=ref
	music_player.play()
	
	
func play_sound(file_name,file_type=".ogg",multiplyer=1.0):
#	print("PLAYING SOUND")
	if(!file_name):return 
	var ref=load("res://Sound/SFX/"+file_name+file_type)
	#current_music=file_name
	#sound_player.stop()
	sound_player.volume_db=-60+(((sfx_volume*multiplyer)/100)*60)
	sound_player.stream=ref
#	sound_player.oneshot=true
	sound_player.play()