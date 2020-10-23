extends RigidBody2D


var tex_00 = preload("res://Sprites/Objects/bowl.png")
var tex_01 = preload("res://Sprites/Objects/bread.png")
var tex_02 = preload("res://Sprites/Objects/cheese_grater.png")
var tex_03 = preload("res://Sprites/Objects/clock.png")
var tex_04 = preload("res://Sprites/Objects/cup.png")
var tex_05 = preload("res://Sprites/Objects/pot.png")
var tex_06 = preload("res://Sprites/Objects/straws.png")
var tex_07 = preload("res://Sprites/Objects/tissue_paper.png")
var tex_08 = preload("res://Sprites/Objects/toilet_paper.png")
var tex_09 = preload("res://Sprites/Objects/tooth_paste.png")

var tex_ref_array = [tex_00, tex_01, tex_02, tex_03, tex_04, tex_05, tex_06,tex_07, tex_08, tex_09]

var pos
var w = 50
var mousePos = Vector2()
var jump = randi()%50+250
var dir = randi()%200-50

# make objects bounce
func _ready():
	$Sprite1.texture = tex_ref_array[GetRandomNumber.array_element_number]
	apply_impulse(Vector2(0,0) , Vector2(dir, -jump))

# make objects disappear when clicked
func _physics_process(delta):
	if Input.is_action_just_pressed("click"):
		mousePos = get_global_mouse_position()
		pos = global_position
		pos.x -= w/2
		pos.y -= w/2
		if mousePos.x >= pos.x and mousePos.x <= pos.x + w and mousePos.y >= pos.y and mousePos.y <= pos.y + w:
			get_parent().points += 1
			queue_free()
	if global_position.y > 500:
		get_parent().fallingObjects +=1
		queue_free() #clear cache
