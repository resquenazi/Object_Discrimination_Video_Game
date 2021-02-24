extends Control

onready var LevelNum = get_node("LevelNum")

func _ready():
	$Start.connect("pressed", self, "Start")
	$Quit.connect("pressed", self, "Quit")
	if PlayerData.level == 2:
		LevelNum.set_text("2")
	if PlayerData.level == 3:
		LevelNum.set_text("3")
	if PlayerData.level == 4:
		LevelNum.set_text("4")
	if PlayerData.level == 5: 
		LevelNum.set_text("5")

func Start():
	get_tree().change_scene("res://Scenes/Game.tscn")

func Quit():
	get_tree().quit()
