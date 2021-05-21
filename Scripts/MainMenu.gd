extends Control

func _ready():
	OS.set_borderless_window(true)
	OS.set_window_position(Vector2(0,0))
	
	MusicController.play_game_music()
	$PlayGame.connect("pressed", self, "PlayGame")
	$Quit.connect("pressed", self, "Quit")

func PlayGame():
	get_tree().change_scene("res://Scenes/UserInput.tscn")

func Quit():
	get_tree().quit()
