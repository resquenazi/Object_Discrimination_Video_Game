extends Node

signal targetObjectsPointsUpdated
signal distractorObjectsPointsUpdated
signal missedObjectsPointsUpdated
signal levelUpdated

var targetObjectsPoints = 0 setget set_targetObjectsPoints #keep score of how many target objects were sliced
var distractorObjectsPoints = 0 setget set_distractorObjectsPoints #keep score of how many distractor objects were sliced
var missedObjectsPoints = 0 setget set_missedObjectsPoints #keep track of missed objects
var level = 1 setget set_level
var dateTimeDict = OS.get_datetime()
var year = dateTimeDict.year
var month = dateTimeDict.month
var day = dateTimeDict.day
var hour = dateTimeDict.hour - 12
var minute = dateTimeDict.minute

var FILE_NAME = "res://Data/" + str(UserInput.playername) + "_" + str(month) + "_" + str(day) + "_" + str(year) + "_" + 	str(hour) + "_" + str(minute) + ".txt"

var player_data = {
	"name": UserInput.playername,
	"Target_Objects_Points": targetObjectsPoints,
	"Distractor_Objects_Points": distractorObjectsPoints,
	"Missed_Objects_Points": missedObjectsPoints,
	"Level": level
}

func set_targetObjectsPoints(value: int) -> void:
	targetObjectsPoints = value
	emit_signal("targetObjectsPointsUpdated")
	
func set_distractorObjectsPoints(value: int) -> void:
	distractorObjectsPoints = value
	emit_signal("distractorObjectsPointsUpdated")
	
func set_missedObjectsPoints(value: int) -> void:
	missedObjectsPoints = value
	emit_signal("missedObjectsPointsUpdated")
	
func set_level(value: int) -> void:
	level = value
	emit_signal("levelUpdated")

func _reset_points():
	targetObjectsPoints = 0
	distractorObjectsPoints = 0
	missedObjectsPoints = 0

func _save():
	var data = ""
	data += "Target_Objects_Points: " + str(targetObjectsPoints)
	data += "\n"
	data += "Distractor_Objects_Points: " + str(distractorObjectsPoints)
	data += "\n"
	data += "Missed_Objects: " + str(missedObjectsPoints)
	var new_file = File.new()
	new_file.open(FILE_NAME, File.WRITE)
	#Store the data and close the file
	new_file.store_line(data)
	new_file.close()
	print("file saved!")
