extends RigidBody2D

var pos
var w = 300
var mousePos = Vector2()
var jump = randi()%150+250
var dir = randi()%200-50
var tex_ref_array = Global.tex_ref_array
var randN = Global.sample
var distractor_object = Global.distractor_object
signal distractorObjectsPoints 
signal missedObjectsPoints

var size = 1

# make objects bounce
func _ready():
	$Sprite2.rotation_degrees = rand_range(-180, 180)
	$Sprite2.texture = tex_ref_array[distractor_object]
	apply_impulse(Vector2(0,0) , Vector2(dir, -jump))

# make objects disappear when clicked
func _physics_process(delta):
	$Sprite2.scale = Vector2(size, size)
	w = size * 300
	if Input.is_action_just_pressed("click"):
		mousePos = get_global_mouse_position()
		pos = global_position
		pos.x -= w/2
		pos.y -= w/2
		if mousePos.x >= pos.x and mousePos.x <= pos.x + w and mousePos.y >= pos.y \
		and mousePos.y <= pos.y + w:
				emit_signal("distractorObjectsPoints")
				queue_free()
	if global_position.y > 851:
		emit_signal("missedObjectsPoints")
		queue_free() #clear cache
