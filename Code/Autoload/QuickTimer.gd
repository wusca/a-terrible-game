#Simple timing functions for typical gameplay that is pausable
extends Node

func create_timer(ref_object,ref_function="",ref_binds=[],ref_time=1):
	var x = Timer.new()
	add_child(x)
	x.set("one_shot",true)
	x.connect("timeout",ref_object,ref_function,ref_binds)
	x.connect("timeout",self,"kill_this",[x])
	x.wait_time=ref_time
	x.start()
func kill_this(object):
	#print("timer killed")
	object.queue_free()