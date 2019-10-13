extends Node

func pick_one(arr=[]):
	#Picks a random element from the array and returns the selected element
	var max_number=0
	var thing_to_return=null
	var x=0
	for thing in arr:
		x=rand_range(0,1)
		if(x>max_number):
			max_number=x
			thing_to_return=thing
	return thing_to_return
func chance(how_likely=20):
	#Returns true if the probability succeeds with the given likliehood, false if the probability fails
	if(rand_range(0,100)<=how_likely):return true
	return false

