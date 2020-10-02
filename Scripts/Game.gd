extends Node2D

var points = 0
var fallingObjects = 0
var start = false
var end = false
export (PackedScene) var Objects
var cDif = 10

func _ready():
	$Score.hide()
	$objects.hide()

func _physics_process(delta):
	$Score.set_text("points: " + str(points))
	$objects.set_text("Missed Objects: " + str(fallingObjects))
	$gameOver.set_text(" ")
	if start and !end:
		if fallingObjects >= 4:
			end = true
		if points > cDif:
			cDif += 10
			$spawn.set_wait_time($spawn.get_wait_time() - 0.1)
	elif !start and !end:
		$gameOver.set_text("Avoid the Toilet Paper")
	else: 
		$gameOver.set_text("Game Over!")

func _on_start_pressed():
	start = true
	$Score.show()
	$objects.show()
	$spawn.start()
	$menu/start.hide()
	#$selection.play()
	
func _on_spawn_timeout():
	if !end:
		var o = Objects.instance()
		o.global_position = Vector2(randi()%700+100 , 400)
		add_child(o)
	else:
		#$final.play()
		$spawn.stop()
