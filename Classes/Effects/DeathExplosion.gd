extends Particles2D


var cd=1.8
func _ready():
	emitting=true
func _process(delta):
	#Just a countdown for death
	cd-=delta
	if(cd<0):
		queue_free()