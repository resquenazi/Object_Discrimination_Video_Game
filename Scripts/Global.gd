extends Node

var list = range(0,38)
var sample =[]
var distractor_objects = []
var target_objects = []


var sneaker = preload("res://Sprites/Objects/Sneaker.png")
var american_flag = preload("res://Sprites/Objects/american_flag.png")
var backpack = preload("res://Sprites/Objects/backpack.png")
var baseball_bat= preload("res://Sprites/Objects/baseball_bat.png")
var baseball_glove = preload("res://Sprites/Objects/baseball_glove.png")
var bath_tub = preload("res://Sprites/Objects/bath_tub.png")
var beer_mug = preload("res://Sprites/Objects/beer_mug.png")
var bicycle = preload("res://Sprites/Objects/bicycle.png")
var binoculars = preload("res://Sprites/Objects/binoculars.png")
var boom_box = preload("res://Sprites/Objects/boom_box.png")
var boxing_glove = preload("res://Sprites/Objects/boxing_glove.png")
var calculator = preload("res://Sprites/Objects/calculator.png")
var computer_monitor = preload("res://Sprites/Objects/computer_monitor.png")
var cowboy_hat= preload("res://Sprites/Objects/cowboy_hat.png")
var desk_globe = preload("res://Sprites/Objects/desk_globe.png")
var dumbell = preload("res://Sprites/Objects/dumbell.png")
var electric_guitar = preload("res://Sprites/Objects/electric_guitar.png")
var fire_extinguisher = preload("res://Sprites/Objects/fire_extinguisher.png")
var flash_light = preload("res://Sprites/Objects/flash_light.png")
var football_helmet = preload("res://Sprites/Objects/football_helmet.png")
var french_horn = preload("res://Sprites/Objects/french_horn.png")
var frying_pan = preload("res://Sprites/Objects/frying_pan.png")
var iPod = preload("res://Sprites/Objects/iPod.png")
var keyboard= preload("res://Sprites/Objects/baseball_bat.png")
var knife = preload("res://Sprites/Objects/knife.png")
var lawn_mower = preload("res://Sprites/Objects/lawn_mower.png")
var light_bulb = preload("res://Sprites/Objects/light_bulb.png")
var megaphone = preload("res://Sprites/Objects/megaphone_1.png")
var microwave = preload("res://Sprites/Objects/microwave.png")
var neck_tie = preload("res://Sprites/Objects/neck_tie.png")
var rotary_phone = preload("res://Sprites/Objects/rotary_phone.png")
var skate_board = preload("res://Sprites/Objects/skate_board.png")
var soccer_ball = preload("res://Sprites/Objects/soccer_ball.png")
var sock= preload("res://Sprites/Objects/sock.png")
var soda_can = preload("res://Sprites/Objects/soda_can.png")
var t_shirt = preload("res://Sprites/Objects/t_shirt.png")
var tea_kettle = preload("res://Sprites/Objects/tea_kettle.png")
var top_hat = preload("res://Sprites/Objects/top_hat.png")


var tex_ref_array = [sneaker, american_flag, backpack, baseball_bat, baseball_glove, bath_tub, beer_mug, bicycle,
 binoculars, boom_box, boxing_glove, calculator, computer_monitor, cowboy_hat, desk_globe, dumbell, electric_guitar,
fire_extinguisher, flash_light, football_helmet, french_horn, frying_pan, iPod, keyboard, knife, lawn_mower, 
light_bulb, megaphone, microwave, neck_tie, rotary_phone, skate_board, soccer_ball, sock, soda_can, t_shirt,
tea_kettle, top_hat]

func _ready():
	randomize()
	for i in range(6):
		var x = randi()%list.size()
		sample.append(list[x])
		list.remove(x)
	print("Array is " + str(sample))
	target_objects = sample.slice(0,3)
	print("Target objects are " + str(target_objects))
	distractor_objects = sample.slice(4,5)
	print("Distractor objects are " + str(distractor_objects))

func _reset_objects():
	list = range(0,10)
	sample =[]
	distractor_objects = []
	target_objects = []

