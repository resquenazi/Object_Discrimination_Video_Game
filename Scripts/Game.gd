extends Node2D

## export scenes
export (PackedScene) var TargetObjects
export (PackedScene) var DistractorObjects

## initialize game variables
var quit = false #quit game
var start = false  #start game
var end = false #end game
var cDif = 10 #points stuff
var countdown = 11
var playername = UserInput.playername #get player name for saving
# initialize variables for difficulty within level
var target_object_timer_length = 2 #seconds
var distractor_object_timer_length = 3 
var distractor_object_timer_start = true
var target_object_timer_start = true
export var level_change_speed = .01 #number of seconds to subtract from timer when player gets score

## set up variables for menu screen
onready var distractor_object = Global.distractor_object #index of object to avoid during the game

var object_labels = ["sneaker", "american_flag", "backpack", "baseball_bat", "baseball_glove", "bath_tub", "beer_mug", "bicycle",
 "binoculars", "boom_box", "boxing_glove", "calculator", "computer_monitor", "cowboy_hat", "desk_globe", "dumbell", "electric_guitar",
"fire_extinguisher", "flash_light", "football_helmet", "french_horn", "frying_pan", "iPod", "keyboard", "knife", "lawn_mower", 
"light_bulb", "megaphone", "microwave", "neck_tie", "rotary_phone", "skate_board", "soccer_ball", "sock", "soda_can", "t_shirt",
"tea_kettle", "top_hat"] #for display of object to avoid


#HUD Stuff
onready var TargetObjectsScoreLabel = get_node("HUD/TargetObjectsScoreLabel")
onready var DistractorObjectsScoreLabel = get_node("HUD/DistractorObjectsScoreLabel")
onready var MissedObjectsLabel = get_node("HUD/MissedObjectsLabel")
onready var StartButton = get_node("HUD/StartButton")
onready var QuitButton = get_node("HUD/QuitButton")
onready var DirectionsLabel = get_node("HUD/DirectionsLabel")
onready var CountdownLabel = get_node("HUD/CountdownLabel")
onready var EnableFilt = get_node("HUD/EnableFilt")

func _ready():
	## hide things once user presses start
	print("Level is " + str(PlayerData.level))
	StartButton.connect("pressed", self, "_on_start_button_pressed")
	QuitButton.connect("pressed", self, "_on_quit_button_pressed")
	TargetObjectsScoreLabel.hide()
	MissedObjectsLabel.hide()
	DistractorObjectsScoreLabel.hide()
	EnableFilt.hide()
	MusicController.play_game_music()


func _process(delta):
	if PlayerData.targetObjectsPoints >= 25:
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
		if PlayerData.missedObjectsPoints >= 25:
			end = true
			_restart_level()
		if PlayerData.targetObjectsPoints > cDif:
			cDif += 10
			$TargetObjectsTimer.set_wait_time($TargetObjectsTimer.get_wait_time() - 0.1)
		if PlayerData.distractorObjectsPoints >= 25: 
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
	$enableFiltSound.play()
	EnableFilt.show()
	$CountDownTimer.start()
	TargetObjectsScoreLabel.show() 
	DistractorObjectsScoreLabel.show()
	MissedObjectsLabel.show()
	StartButton.hide()
	
func _on_TargetObjectsTimer_timeout():
	target_object_timer_start = true
	if !end:
		var t = TargetObjects.instance()
		t.connect("targetObjectsPoints", self, "_on_target_object_sliced")
		t.connect("missedObjectsPoints", self, "_on_missed_target_object")
		t.global_position = Vector2(randi()%1000+100, 680) #Vector2(#,#) controls x & y start positions of objects
		add_child(t)
		if PlayerData.level == 1:
			t.size = .35
		if PlayerData.level == 2:
			t.size = .26
		if PlayerData.level == 3:
			t.size = .19
		if PlayerData.level == 4:
			t.size = .13
		if PlayerData.level == 5:
			t.size = .09
		if PlayerData.level == 6:
			t.size = .05
	else:
		$TargetObjectsTimer.stop()

func _on_DistractorObjectsTimer_timeout():
	distractor_object_timer_start = true
	if !end:
		var d = DistractorObjects.instance()
		d.connect("distractorObjectsPoints", self, "_on_distractor_object_sliced")
		d.connect("missedObjectsPoints", self, "_on_missed_target_object")
		d.global_position = Vector2(randi()%1000+100, 680) #Vector2(#,#) controls x & y start positions of objects
		add_child(d)
		if PlayerData.level == 1:
			d.size = .35
		if PlayerData.level == 2:
			d.size = .26
		if PlayerData.level == 3:
			d.size = .19
		if PlayerData.level == 4:
			d.size = .13
		if PlayerData.level == 5:
			d.size = .09
		if PlayerData.level == 6:
			d.size = .05
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
	$targetObjectsPointsSound.play()
	TargetObjectsScoreLabel.set_text("Target Objects Hit: " + str(PlayerData.targetObjectsPoints))

func _on_missed_target_object():
	PlayerData.missedObjectsPoints += 1
	MissedObjectsLabel.set_text("Missed Objects: " + str(PlayerData.missedObjectsPoints))

func _on_distractor_object_sliced():
	if distractor_object_timer_length > 0:
		distractor_object_timer_length -= level_change_speed #increase difficulty of game by making objects spawn faster
		print("distractor timer" + str(distractor_object_timer_length))
	PlayerData.distractorObjectsPoints += 1
	$distractorObjectsPointsSound.play()
	DistractorObjectsScoreLabel.set_text("Distractor Objects Hit " + str(PlayerData.distractorObjectsPoints))


func _on_CountDownTimer_timeout():
	countdown -= 1
	print(str(countdown))
	if not countdown == 0:
		CountdownLabel.set_text(str(countdown))
		
	else:
		start = true
		$TargetObjectsTimer.start()
		$DistractorObjectsTimer.start()
		$CountDownTimer.stop()
		DirectionsLabel.hide()
		CountdownLabel.hide()
		EnableFilt.hide()
