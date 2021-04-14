extends Control

onready var RestartDirections = get_node("ColorRect/RestartDirections")
onready var TargetObjectsScoreLabel = get_node("TargetObjectsScoreLabel")
onready var DistractorObjectsScoreLabel = get_node("DistractorObjectsScoreLabel")
onready var MissedObjectsScoreLabel = get_node("MissedObjectsScoreLabel")
onready var distractor_object = Global.distractor_object #index of object to avoid during the game
onready var TargetObjectsPoints = PlayerData.targetObjectsPoints
onready var DistractorObjectsPoints = PlayerData.distractorObjectsPoints
onready var MissedObjectsPoints = PlayerData.missedObjectsPoints

var object_labels = ["sneaker", "american_flag", "backpack", "baseball_bat", "baseball_glove", "bath_tub", "beer_mug", "bicycle",
 "binoculars", "boom_box", "boxing_glove", "calculator", "computer_monitor", "cowboy_hat", "desk_globe", "dumbell", "electric_guitar",
"fire_extinguisher", "flash_light", "football_helmet", "french_horn", "frying_pan", "iPod", "keyboard", "knife", "lawn_mower", 
"light_bulb", "megaphone", "microwave", "neck_tie", "rotary_phone", "skate_board", "soccer_ball", "sock", "soda_can", "t_shirt",
"tea_kettle", "top_hat"] #for display of object to avoid

func _ready():
	$ColorRect/RestartButton.connect("pressed", self, "RestartGame")
	$Quit.connect("pressed", self, "Quit")
	
	TargetObjectsScoreLabel.set_text("Target Objects Score: " + str(TargetObjectsPoints))
	
	$disableFilt.play()
	
	var object_avoid = str(object_labels[distractor_object])
	var object_avoid2 = object_avoid.replace("_", " ")
	DistractorObjectsScoreLabel.set_text("Number of " + str(object_avoid2) + " hit: " + str(DistractorObjectsPoints))
	
	MissedObjectsScoreLabel.set_text("Number of missed objects: " + str(MissedObjectsPoints))
	
func _physics_process(delta):
	if PlayerData.missedObjectsPoints >= 10:
		RestartDirections.set_text("You missed too many objects! Restart the game and try to advance to the next level!")
	if PlayerData.distractorObjectsPoints >=10: 
		RestartDirections.set_text("You slashed too many incorrect objects! Restart the game and try to advance to the next level!")

func RestartGame():
	PlayerData._reset_points()
	Global._reset_objects()
	Global._ready()
	get_tree().change_scene("res://Scenes/Game.tscn")

func Quit():
	get_tree().quit()
