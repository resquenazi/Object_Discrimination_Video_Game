extends Control

onready var RestartDirections = get_node("RestartDirections")

func _ready():
	$RestartButton.connect("pressed", self, "RestartGame")
	$Quit.connect("pressed", self, "Quit")
	
func _physics_process(delta):
	if PlayerData.missedObjectsPoints >= 10:
		RestartDirections.set_text("You missed too many objects! Restart the game and try to advance to the next level!")
	if PlayerData.distractorObjectsPoints >=10: 
		RestartDirections.set_text("You slashed too many incorrect objects! Restart the game and try to advance to the next level!")

func RestartGame():
	get_tree().change_scene("res://Scenes/Game.tscn")

func Quit():
	get_tree().quit()
