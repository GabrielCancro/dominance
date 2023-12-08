extends Node

var StopMouseNode
var amount = 0

func _ready():
	Input.set_custom_mouse_cursor( preload("res://assets/cursor_arrow.png") )

func set_stop_mouse(val):
#	StopMouseNode.visible = val
	if val: amount += 1
	else: amount -= 1
	print("STOP MOUSE ",amount)
	StopMouseNode.visible = (amount>0)
