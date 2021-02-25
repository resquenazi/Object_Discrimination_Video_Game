extends Node2D

## export scenes
export (PackedScene) var TargetObjects
export (PackedScene) var DistractorObjects

## initialize game variables
var quit = false #quit game
var start = false  #start game
var end = false #end game
var cDif = 10 #points stuff
var playername = UserInput.playername #get player name for saving
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
	print("Level is " + str(PlayerData.level))
	StartButton.connect("pressed", self, "_on_start_button_pressed")
	QuitButton.connect("pressed", self, "_on_quit_button_pressed")
	TargetObjectsScoreLabel.hide()
	MissedObjectsLabel.hide()
	DistractorObjectsScoreLabel.hide()

func _process(delta):
	if PlayerData.targetObjectsPoints >= 5:
		_level_switch()
		if PlayerData.level >= 7:
			end = true
			PlayerData._save()
			get_tree().change_scene("res://Scenes/Restart.tscn")
			

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
		if PlayerData.missedObjectsPoints >= 10:
			end = true
			_restart_level()
		if PlayerData.targetObjectsPoints > cDif:
			cDif += 10
			$TargetObjectsTimer.set_wait_time($TargetObjectsTimer.get_wait_time() - 0.1)
		if PlayerData.distractorObjectsPoints >= 10: 
			_restart_level()
			end = true
			#_reset()

	# beginning directions
	elif !start and !end:
		var object_avoid = str(object_labels[distractor_object])
		var object_avoid2 = object_avoid.replace("_", " ")
		DirectionsLabel.set_text("Avoid the " + str(object_avoid2))

	# end text
	else:
		DirectionsLabel.hide()
		PlayerData._save()

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
		t.global_position = Vector2(randi()%900+100, 850) #Vector2(#,#) controls x & y start positions of objects
		add_child(t)
		if PlayerData.level == 1:
			t.size = .45
		if PlayerData.level == 2:
			t.size = .36
		if PlayerData.level == 3:
			t.size = .29
		if PlayerData.level == 4:
			t.size = .23
		if PlayerData.level == 5:
			t.size = .19
		if PlayerData.level == 6:
			t.size = .15
	else:
		$TargetObjectsTimer.stop()

func _on_DistractorObjectsTimer_timeout():
	distractor_object_timer_start = true
	if !end:
		var d = DistractorObjects.instance()
		d.connect("distractorObjectsPoints", self, "_on_distractor_object_sliced")
		d.connect("missedObjectsPoints", self, "_on_missed_target_object")
		d.global_position = Vector2(randi()%900+100, 850) #Vector2(#,#) controls x & y start positions of objects
		add_child(d)
		if PlayerData.level == 1:
			d.size = .45
		if PlayerData.level == 2:
			d.size = .36
		if PlayerData.level == 3:
			d.size = .29
		if PlayerData.level == 4:
			d.size = .23
		if PlayerData.level == 5:
			d.size = .19
		if PlayerData.level == 6:
			d.size = .15
	else:
		$DistractorObjectsTimer.stop()

func _level_switch():
	PlayerData._save()
	PlayerData.level += 1 
	get_tree().change_scene("res://Scenes/LevelSwitch.tscn")
	
func _restart_level():
	PlayerData._save()
	get_tree().change_scene("res://Scenes/Restart.tscn")

func _on_quit_button_pressed():
	PlayerData._save()
	get_tree().quit()
	
func _on_target_object_sliced():
	if target_object_timer_length > 0:
		target_object_timer_length -= level_change_speed #increase difficulty of game by making objects spawn faster
		print("target timer" + str(target_object_timer_length))
	PlayerData.targetObjectsPoints += 1
	TargetObjectsScoreLabel.set_text("Target Objects Hit: " + str(PlayerData.targetObjectsPoints))

func _on_missed_target_object():
	PlayerData.missedObjectsPoints += 1
	MissedObjectsLabel.set_text("Missed Objects: " + str(PlayerData.missedObjectsPoints))

func _on_distractor_object_sliced():
	if distractor_object_timer_length > 0:
		distractor_object_timer_length -= level_change_speed #increase difficulty of game by making objects spawn faster
		print("distractor timer" + str(distractor_object_timer_length))
	PlayerData.distractorObjectsPoints += 1
	DistractorObjectsScoreLabel.set_text("Distractor Objects Hit " + str(PlayerData.distractorObjectsPoints))
