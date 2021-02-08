extends Node2D

## export scenes
export (PackedScene) var TargetObjects
export (PackedScene) var DistractorObjects

## initialize game variables
var quit = false #quit game
var targetObjectsPoints = 0 #keep score of how many target objects were sliced
var distractorObjectsPoints = 0 #keep score of how many distractor objects were sliced
var missedObjectsPoints = 0 #keep track of missed objects
var start = false  #start game
var end = false #end game
var cDif = 10 #points stuff
var randN = Global.sample #get random number generated from global script
var playername = UserInput.playername #get player name for saving
var dateTimeDict = OS.get_datetime()
var day = dateTimeDict.weekday
var hour = dateTimeDict.hour
var minute = dateTimeDict.minute

# initialize variables for difficulty within level
var target_object_timer_length = 2 #seconds
var distractor_object_timer_length = 3 
var distractor_object_timer_start = true
var target_object_timer_start = true
export var level_change_speed = .01 #number of seconds to subtract from timer when player gets score

## set up variables for menu screen
onready var distractor_object = Global.distractor_object #index of object to avoid during the game
var object_labels = ["bowl", "bread", "cheese_grater", "clock", "cup", "pot", "straws",
 "tissue_paper", "toilet_paper", "tooth_paste"] #for display of object to avoid

#HUD Stuff
onready var TargetObjectsScoreLabel = get_node("HUD/TargetObjectsScoreLabel")
onready var DistractorObjectsScoreLabel = get_node("HUD/DistractorObjectsScoreLabel")
onready var MissedObjectsLabel = get_node("HUD/MissedObjectsLabel")
onready var StartButton = get_node("HUD/StartButton")
onready var QuitButton = get_node("HUD/QuitButton")
onready var DirectionsLabel = get_node("HUD/DirectionsLabel")


func _ready():
	## hide things once user presses start
	StartButton.connect("pressed", self, "_on_start_button_pressed")
	QuitButton.connect("pressed", self, "_on_quit_button_pressed")
	TargetObjectsScoreLabel.hide()
	MissedObjectsLabel.hide()
	DistractorObjectsScoreLabel.hide()


func _physics_process(delta): 

	if start and !end:
		if distractor_object_timer_start == true:
			$DistractorObjectsTimer.start(distractor_object_timer_length)
			distractor_object_timer_start = false
		if target_object_timer_start == true:
			$TargetObjectsTimer.start(target_object_timer_length)
			target_object_timer_start = false

	# determine when game ends
	if start and !end:
		if missedObjectsPoints >= 10:
			end = true
			_save()
			get_tree().change_scene("res://Scenes/Restart.tscn")
		if targetObjectsPoints > cDif:
			cDif += 10
			$TargetObjectsTimer.set_wait_time($TargetObjectsTimer.get_wait_time() - 0.1)

	# beginning directions
	elif !start and !end:
		var object_avoid = str(object_labels[distractor_object])
		var object_avoid2 = object_avoid.replace("_", " ")
		DirectionsLabel.set_text("Avoid the " + str(object_avoid2))

	# end text
	else:
		DirectionsLabel.hide()
		_save()

## instance scenes
func _on_start_button_pressed():
	start = true
	TargetObjectsScoreLabel.show() 
	DistractorObjectsScoreLabel.show()
	MissedObjectsLabel.show()
	$TargetObjectsTimer.start()
	$DistractorObjectsTimer.start()
	StartButton.hide()
	DirectionsLabel.hide()
	
func _on_TargetObjectsTimer_timeout():
	target_object_timer_start = true
	if !end:
		var t = TargetObjects.instance()
		t.connect("targetObjectsPoints", self, "_on_target_object_sliced")
		t.connect("missedObjectsPoints", self, "_on_missed_target_object")
		t.global_position = Vector2(randi()%900+100, 600) #Vector2(#,#) controls x & y start positions of objects
		add_child(t)
	else:
		$TargetObjectsTimer.stop()

func _on_DistractorObjectsTimer_timeout():
	distractor_object_timer_start = true
	if !end:
		var d = DistractorObjects.instance()
		d.connect("distractorObjectsPoints", self, "_on_distractor_object_sliced")
		d.connect("missedObjectsPoints", self, "_on_missed_target_object")
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
	data += "Missed_Objects: " + str(missedObjectsPoints)
	var new_file = File.new()
	new_file.open("res://Data/" + str(playername) + "_" + str(day) + "_" + str(hour) + "_" + str(minute) + ".txt", File.WRITE)
	#Store the data and close the file
	new_file.store_line(data)
	new_file.close()

func _on_quit_button_pressed():
	_save()
	get_tree().quit()
	
func _on_target_object_sliced():
	if target_object_timer_length > 0:
		target_object_timer_length -= level_change_speed #increase difficulty of game by making objects spawn faster
		print("target timer" + str(target_object_timer_length))
	targetObjectsPoints += 1
	TargetObjectsScoreLabel.set_text("Target Objects Hit: " + str(targetObjectsPoints))

func _on_missed_target_object():
	missedObjectsPoints += 1
	MissedObjectsLabel.set_text("Missed Objects: " + str(missedObjectsPoints))

func _on_distractor_object_sliced():
	if distractor_object_timer_length > 0:
		distractor_object_timer_length -= level_change_speed #increase difficulty of game by making objects spawn faster
		print("distractor timer" + str(distractor_object_timer_length))
	distractorObjectsPoints += 1
	DistractorObjectsScoreLabel.set_text("Distractor Objects Hit " + str(distractorObjectsPoints))
