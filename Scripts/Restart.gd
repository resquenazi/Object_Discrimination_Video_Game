extends Control

onready var RestartDirections = get_node("RestartDirections")
onready var TargetObjectsScoreLabel = get_node("TargetObjectsScoreLabel")
onready var DistractorObjectsScoreLabel = get_node("DistractorObjectsScoreLabel")
onready var MissedObjectsScoreLabel = get_node("MissedObjectsScoreLabel")
onready var distractor_object = Global.distractor_object #index of object to avoid during the game
onready var TargetObjectsPoints = PlayerData.targetObjectsPoints
onready var DistractorObjectsPoints = PlayerData.distractorObjectsPoints
onready var MissedObjectsPoints = PlayerData.missedObjectsPoints

var object_labels = ["bowl", "bread", "cheese_grater", "clock", "cup", "pot", "straws",
 "tissue_paper", "toilet_paper", "tooth_paste"] #for display of object to avoid

func _ready():
	$RestartButton.connect("pressed", self, "RestartGame")
	$Quit.connect("pressed", self, "Quit")
	
	TargetObjectsScoreLabel.set_text("Target Objects Score: " + str(TargetObjectsPoints))
	
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
