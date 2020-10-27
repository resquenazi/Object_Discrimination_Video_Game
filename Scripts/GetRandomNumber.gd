extends Node

var list = range(0,10)
var sample =[]

func _ready():
	randomize()
	for i in range(3):
		var x = randi()%list.size()
		sample.append(list[x])
		list.remove(x)
	print(sample)
	print(sample[1])

