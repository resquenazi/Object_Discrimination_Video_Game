extends Node

var list = range(0,10)
var sample =[]
var object_avoid_idx = []

func _ready():
	randomize()
	for i in range(3):
		var x = randi()%list.size()
		sample.append(list[x])
		list.remove(x)
	print(sample)
	object_avoid_idx = sample[randi() % sample.size()]
	print(object_avoid_idx)
