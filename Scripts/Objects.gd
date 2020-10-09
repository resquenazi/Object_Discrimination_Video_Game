extends RigidBody2D

#set up variables
var pos
var w = 50
var mousePos = Vector2()
var frame = randi()%5 
var jump = randi()%50+250
var dir = randi()%200-50

# make objects bounce
func _ready():
	$objects.set_frame(frame)
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
