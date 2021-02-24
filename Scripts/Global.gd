extends Node

var list = range(0,10)
var sample =[]
var distractor_object = []
var target_objects = []


var bowl = preload("res://Sprites/Objects/bowl.png")
var bread = preload("res://Sprites/Objects/bread.png")
var cheese_grater = preload("res://Sprites/Objects/cheese_grater.png")
var clock= preload("res://Sprites/Objects/clock.png")
var cup = preload("res://Sprites/Objects/cup.png")
var pot = preload("res://Sprites/Objects/pot.png")
var straws = preload("res://Sprites/Objects/straws.png")
var tissue_paper = preload("res://Sprites/Objects/tissue_paper.png")
var toilet_paper = preload("res://Sprites/Objects/toilet_paper.png")
var tooth_paste = preload("res://Sprites/Objects/tooth_paste.png")

var tex_ref_array = [bowl, bread, cheese_grater, clock, cup, pot, straws, tissue_paper,
 toilet_paper, tooth_paste]

func _ready():
	randomize()
	for i in range(4):
		var x = randi()%list.size()
		sample.append(list[x])
		list.remove(x)
	print("Array is " + str(sample))
	target_objects = sample.slice(0,2)
	print("Target objects are " + str(target_objects))
	distractor_object = sample[3]
	print("Distractor object is " + str(distractor_object))

func _reset_objects():
	list = range(0,10)
	sample =[]
	distractor_object = []
	target_objects = []

