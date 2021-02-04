extends Control

func _ready():
	$PlayGame.connect("pressed", self, "PlayGame")
	$Quit.connect("pressed", self, "Quit")

func PlayGame():
	get_tree().change_scene("res://Scenes/UserInput.tscn")


func Quit():
	get_tree().quit()
