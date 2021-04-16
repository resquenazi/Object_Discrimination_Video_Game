extends Control


onready var TargetObjectsScoreLabel = get_node("ColorRect/TargetObjectsScoreLabel")
onready var DistractorObjectsScoreLabel = get_node("ColorRect/DistractorObjectsScoreLabel")
onready var MissedObjectsScoreLabel = get_node("ColorRect/MissedObjectsScoreLabel")
onready var distractor_objects = Global.distractor_objects #index of object to avoid during the game
onready var TargetObjectsPoints = PlayerData.targetObjectsPoints
onready var DistractorObjectsPoints = PlayerData.distractorObjectsPoints
onready var MissedObjectsPoints = PlayerData.missedObjectsPoints

var object_labels = ["sneaker", "american_flag", "backpack", "baseball_bat", "baseball_glove", "bath_tub", "beer_mug", "bicycle",
 "binoculars", "boom_box", "boxing_glove", "calculator", "computer_monitor", "cowboy_hat", "desk_globe", "dumbell", "electric_guitar",
"fire_extinguisher", "flash_light", "football_helmet", "french_horn", "frying_pan", "iPod", "keyboard", "knife", "lawn_mower", 
"light_bulb", "megaphone", "microwave", "neck_tie", "rotary_phone", "skate_board", "soccer_ball", "sock", "soda_can", "t_shirt",
"tea_kettle", "top_hat"] #for display of object to avoid

func _ready():
	$RestartButton.connect("pressed", self, "RestartGame")
	$Quit.connect("pressed", self, "Quit")
	$disableFilt.play()
	MusicController.stop_game_music()
	$winMusic.play()
	
	
	TargetObjectsScoreLabel.set_text("Target Objects Score: " + str(TargetObjectsPoints))
	DistractorObjectsScoreLabel.set_text("Number of distractors hit: " + str(DistractorObjectsPoints))
	MissedObjectsScoreLabel.set_text("Number of missed objects: " + str(MissedObjectsPoints))

func RestartGame():
	PlayerData._reset_points()
	Global._reset_objects()
	Global._ready()
	get_tree().change_scene("res://Scenes/Game.tscn")
	PlayerData.level = 1

func Quit():
	get_tree().quit()
