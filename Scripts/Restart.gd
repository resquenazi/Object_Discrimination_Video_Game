extends Control


func _ready():
	$RestartButton.connect("pressed", self, "RestartGame")
	$Quit.connect("pressed", self, "Quit")

func RestartGame():
	get_tree().change_scene("res://Scenes/Game.tscn")

func Quit():
	get_tree().quit()
	
