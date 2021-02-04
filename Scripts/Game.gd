extends Node2D

## export scenes
export (PackedScene) var TargetObjects
export (PackedScene) var DistractorObjects

## initialize game variables
var quit = false
var targetObjectsPoints = 0 #keep score of how many target objects were sliced
var distractorObjectsPoints = 0
var fallingObjects = 0 #keep track of missed objects
var start = false  #start game
var end = false #end game
var cDif = 10 #points stuff
var randN = Global.sample
var playername = UserInput.playername
var dateTimeDict = OS.get_datetime()
var day = dateTimeDict.weekday
var hour = dateTimeDict.hour
var minute = dateTimeDict.minute

## set up variables for menu screen
onready var distractor_object = Global.distractor_object #index of object to avoid during the game
var object_labels = ["bowl", "bread", "cheese_grater", "clock", "cup", "pot", "straws",
 "tissue_paper", "toilet_paper", "tooth_paste"] #for display of object to avoid

## hide things once user presses start
func _ready():
	$Start.connect("pressed", self, "_on_start_pressed")
	$Quit.connect("pressed", self, "_on_quit_pressed")
	$TargetObjectsScoreLabel.hide()
	$MissedObjectsLabel.hide()
	$DistractorObjectsScoreLabel.hide()

## set up score keeping
func _physics_process(delta): 
	$TargetObjectsScoreLabel.set_text("Target Objects Hit: " + str(targetObjectsPoints))
	$MissedObjectsLabel.set_text("Missed Objects: " + str(fallingObjects))
	$DistractorObjectsScoreLabel.set_text("Distractor Objects Hit " + str(distractorObjectsPoints))
	$GameOver.set_text(" ")
	
	# determine when game ends
	if start and !end:
		if fallingObjects >= 10:
			end = true
		if targetObjectsPoints > cDif:
			cDif += 10
			$TargetObjectsTimer.set_wait_time($TargetObjectsTimer.get_wait_time() - 0.1)

	# beginning directions
	elif !start and !end:
		var object_avoid = str(object_labels[distractor_object])
		var object_avoid2 = object_avoid.replace("_", " ")
		$GameOver.set_text("Avoid the " + str(object_avoid2))
	# end text
	else:
		$GameOver.set_text("Game Over!")
		_save()

## instance scenes
func _on_Start_pressed():
	start = true
	$TargetObjectsScoreLabel.show() 
	$DistractorObjectsScoreLabel.show()
	$MissedObjectsLabel.show()
	$TargetObjectsTimer.start()
	$DistractorObjectsTimer.start()
	$Start.hide()

func _on_TargetObjectsTimer_timeout():
	if !end:
		var t = TargetObjects.instance()
		t.global_position = Vector2(randi()%900+100, 600) #Vector2(#,#) controls x & y start positions of objects
		add_child(t)
	else:
		$TargetObjectsTimer.stop()

func _on_DistractorObjectsTimer_timeout():
	if !end:
		var d = DistractorObjects.instance()
		d.global_position = Vector2(randi()%900+100, 600) #Vector2(#,#) controls x & y start positions of objects
		add_child(d)
	else:
		$DistractorObjectsTimer.stop()

func _save():
	# Create an empty string to hold the information
	var data = ""
	data += "Target_Objects_Points: " + str(targetObjectsPoints)
	data += "\n"
	data += "Distractor_Objects_Points: " + str(distractorObjectsPoints)
	data += "\n"
	data += "Missed_Objects: " + str(fallingObjects)
	var new_file = File.new()
	#new_file.open("res://Data/savegame.txt")
	new_file.open("res://Data/" + str(playername) + "_" + str(day) + "_" + str(hour) + "_" + str(minute) + ".txt", File.WRITE)
	#Store the data and close the file
	new_file.store_line(data)
	new_file.close()

func _on_quit_pressed():
	_save()
	get_tree().quit()
