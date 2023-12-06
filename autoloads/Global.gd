extends Node

var StopMouseNode

func _ready():
	Input.set_custom_mouse_cursor( preload("res://assets/cursor_arrow.png") )

func set_stop_mouse(val):
	StopMouseNode.visible = val
