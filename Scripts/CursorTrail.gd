extends Line2D

var length = 10

func _process(delta):
	if Input.is_action_pressed("click"):
		add_point(get_global_mouse_position())
		while get_point_count() > length:
			remove_point(0)
	if Input.is_action_just_released("click"):
		clear_points()
