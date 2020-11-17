extends Control

var playername 

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartGame.connect("pressed", self, "StartGame")


func StartGame():
	get_tree().change_scene("res://Scenes/Game.tscn")
	
func _onLineEdittextentered(newtext):
	playername = newtext
	print(playername)
