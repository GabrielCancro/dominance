extends Node

var current_level

var LEVELS


func _ready():
	pass # Replace with function body.

func get_current_level_data():
	return {"name":current_level,"grid_size":5}

func get_current_rain_day():
	return 2

func get_current_fog_day():
	return 1
