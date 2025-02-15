extends Node

var current_level
var is_rain = false
var is_fog = false

var LEVELS


func _ready():
	pass # Replace with function body.

func get_current_level_data():
	return {"name":current_level,"grid_size":5}

func check_rain():
	if get_node("/root/Game/DayCounter").day==2:
		return 2

func get_current_fog_day():
	return 1
