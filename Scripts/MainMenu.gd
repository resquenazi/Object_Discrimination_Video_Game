extends Control

func _ready():
	MusicController.play_game_music()
	$PlayGame.connect("pressed", self, "PlayGame")
	$Quit.connect("pressed", self, "Quit")

func PlayGame():
	get_tree().change_scene("res://Scenes/UserInput.tscn")

func Quit():
	get_tree().quit()
