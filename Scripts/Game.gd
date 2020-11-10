extends Node2D

## export scenes
export (PackedScene) var TargetObjects
export (PackedScene) var DistractorObjects

## initialize game variables
var points = 0 #keep score
var fallingObjects = 0 #keep track of missed objects
var start = false  #start game
var end = false #end game
var cDif = 10 #points stuff
var randN = Global.sample

## set up variables for menu screen
onready var distractor_object = Global.distractor_object #index of object to avoid during the game
var object_labels = ["bowl", "bread", "cheese_grater", "clock", "cup", "pot", "straws",
 "tissue_paper", "toilet_paper", "tooth_paste"] #for display of object to avoid

## hide things once user presses start
func _ready():
	$ScoreLabel.hide()
	$MissedObjects.hide()

## set up score keeping
func _physics_process(delta): 
	$ScoreLabel.set_text("points: " + str(points))
	$MissedObjects.set_text("Missed Objects: " + str(fallingObjects))
	$GameOver.set_text(" ")
	
	# determine when game ends
	if start and !end:
		if fallingObjects >= 4:
			end = true
		if points > cDif:
			cDif += 10
			$TargetObjectsTimer.set_wait_time($TargetObjectsTimer.get_wait_time() - 0.1)

	# beginning directions
	elif !start and !end:
		$GameOver.set_text("Avoid the " + str(object_labels[distractor_object]))
	# end text
	else:
		$GameOver.set_text("Game Over!")

## instance scenes
func _on_Start_pressed():
	start = true
	$ScoreLabel.show() 
	$MissedObjects.show()
	$TargetObjectsTimer.start()
	$DistractorObjectsTimer.start()
	$Menu/Start.hide()

func _on_TargetObjectsTimer_timeout():
	if !end:
		var t = TargetObjects.instance()
		t.global_position = Vector2(randi()%900+100, 500)
		add_child(t)
	else:
		#$final.play()
		$TargetObjectsTimer.stop()

func _on_DistractorObjectsTimer_timeout():
	if !end:
		var d = DistractorObjects.instance()
		d.global_position = Vector2(randi()%900+100, 500)
		add_child(d)
	else:
		#$final.play()
		$DistractorObjectsTimer.stop()
