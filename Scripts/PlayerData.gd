extends Node

signal targetObjectsPointsUpdated
signal distractorObjectsPointsUpdated
signal missedObjectsPointsUpdated
signal levelUpdated
signal died

var targetObjectsPoints = 0 setget set_targetObjectsPoints #keep score of how many target objects were sliced
var distractorObjectsPoints = 0 setget set_distractorObjectsPoints #keep score of how many distractor objects were sliced
var missedObjectsPoints = 0 setget set_missedObjectsPoints #keep track of missed objects
var deaths = 0 setget set_deaths
var level = 7 setget set_level
var dateTimeDict = OS.get_datetime()
var year = dateTimeDict.year
var month = dateTimeDict.month
var day = dateTimeDict.day
var hour = dateTimeDict.hour 
var minute = dateTimeDict.minute
var time_return = String(hour) + ":" + String(minute)

const OPEN_ERROR = 'ERROR: Failed to open "%s". Error code %s.'
const DIR_ERROR = 'ERROR: Failed to create directory "%s". Error code %s.'


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

func set_deaths (value: int) -> void:
	deaths = value
	emit_signal("died")
	
func _reset_points():
	targetObjectsPoints = 0
	distractorObjectsPoints = 0
	missedObjectsPoints = 0

func _reset_deaths():
	deaths = 0


func _save():
	var directory = Directory.new()
	
	# Potential solution 2:
	var DIR_PATH = "user://save/" + UserInput.playername + "/"
	if directory.dir_exists(DIR_PATH):
		print("Directory exists!")
	else:
		var error_code = directory.make_dir_recursive(DIR_PATH)
		if error_code != OK:
			printerr(DIR_ERROR % [DIR_PATH, error_code])

	var FILE_NAME = DIR_PATH + str(month) + "_" + str(day) + "_" + str(year) + ".txt"
	var data = ""
	data += "Time: " + str(time_return)
	data += "\n"
	data += "Level: " + str(level)
	data += "\n"
	data += "Deaths: " + str(deaths)
	data += "\n"
	data += "Target_Objects_Points: " + str(targetObjectsPoints)
	data += "\n"
	data += "Distractor_Objects_Points: " + str(distractorObjectsPoints)
	data += "\n"
	data += "Missed_Objects: " + str(missedObjectsPoints)
	data += "\n"
	
	var new_file = File.new()

	var error_code
	if new_file.file_exists(FILE_NAME):
		error_code = new_file.open(FILE_NAME, File.READ_WRITE)
	else:
		error_code = new_file.open(FILE_NAME, File.WRITE)

	if error_code == OK:
		new_file.seek_end()
		#Store the data and close the file
		new_file.store_line(data)
		new_file.close()
		print("file saved!")
	else:
		printerr(OPEN_ERROR % [FILE_NAME, error_code])
	
