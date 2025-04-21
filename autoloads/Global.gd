extends Node

var StopMouseNode
var amount = 0
var main_menu_never_showed = true
var demo = false
var tuto = false
var debug = false
signal end_magic

func _ready():
	Input.set_custom_mouse_cursor( load("res://assets/cursor.png") )

func set_stop_mouse(val):
	if !StopMouseNode: return
#	StopMouseNode.visible = val
	if val: amount += 1
	else: amount -= 1
	if amount<0: amount = 0
	#print("STOP MOUSE ",amount)
	StopMouseNode.visible = (amount>0)

func clear_stop_mouse():
	amount = 0
	set_stop_mouse(false)
