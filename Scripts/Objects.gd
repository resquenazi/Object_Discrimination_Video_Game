extends RigidBody2D


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

var randN = GetRandomNumber.sample


var pos
var w = 80
var mousePos = Vector2()
var jump = randi()%50+250
var dir = randi()%200-50

# make objects bounce
func _ready():
	$Sprite1.texture = tex_ref_array[randN[randi()%randN.size()]]
	apply_impulse(Vector2(0,0) , Vector2(dir, -jump))
	

# make objects disappear when clicked
func _physics_process(delta):
	if Input.is_action_just_pressed("click"):
		mousePos = get_global_mouse_position()
		pos = global_position
		pos.x -= w/2
		pos.y -= w/2
		if mousePos.x >= pos.x and mousePos.x <= pos.x + w and mousePos.y >= pos.y \
		and mousePos.y <= pos.y + w:
				get_parent().points += 1
				queue_free()
	if global_position.y > 500:
		get_parent().fallingObjects +=1
		queue_free() #clear cache
