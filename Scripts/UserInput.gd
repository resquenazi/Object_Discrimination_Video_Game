extends Control

var playername

func _on_LineEdit_text_entered(new_text):
	UserInput.playername = new_text
	print(UserInput.playername)
	get_tree().change_scene("res://Scenes/Game.tscn")
	
