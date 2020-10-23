extends Node2D

var points = 0 #keep score
var fallingObjects = 0 #keep track of missed objects
var start = false  #start game
var end = false #end game
export (PackedScene) var Objects
var cDif = 10 #points stuff

# hide things once user presses start
func _ready():
	$Score.hide()
	$missedObjects.hide()


func _physics_process(delta):
	
	# set up score keeping 
	$Score.set_text("points: " + str(points))
	$missedObjects.set_text("Missed Objects: " + str(fallingObjects))
	$gameOver.set_text(" ")
	
	# determine when game ends
	if start and !end:
		if fallingObjects >= 4:
			end = true
		if points > cDif:
			cDif += 10
			$spawn.set_wait_time($spawn.get_wait_time() - 0.1)

	# beginning directions
	elif !start and !end:
		$gameOver.set_text("Avoid the Toilet Paper")
	# end text
	else: 
		$gameOver.set_text("Game Over!")

	# game start
func _on_start_pressed():
	start = true
	$Score.show() 
	$missedObjects.show()
	$spawn.start()
	$menu/start.hide()

func _on_spawn_timeout():
	if !end:
		var o = Objects.instance()
		#o.global_position = Vector2(randi()%700+100 , 400)
		add_child(o)
	else:
		#$final.play()
		$spawn.stop()
