extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_game_music():
	$GameMusic.play()

func stop_menu_music():
	$MainMenuMusic.stop()

func stop_game_music():
	$GameMusic.stop()
