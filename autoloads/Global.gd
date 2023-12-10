extends Node

var StopMouseNode
var amount = 0
signal end_magic

func _ready():
	Input.set_custom_mouse_cursor( preload("res://assets/cursor_arrow.png") )

func set_stop_mouse(val):
#	StopMouseNode.visible = val
	if val: amount += 1
	else: amount -= 1
	print("STOP MOUSE ",amount)
	StopMouseNode.visible = (amount>0)

func magic_thundre(unit):
	yield(get_tree().create_timer(.3),"timeout")
	var th = get_node("/root/Game/Map").get_node("Thundre")
	th.rect_position = unit.rect_position
	yield(get_tree().create_timer(.2),"timeout")
	th.visible = true
	Sounds.play_sound("thundre1")
	Effects.shine(unit)
	Effects.shine(th)
	Effects.shake(th)
	yield(get_tree().create_timer(.3),"timeout")
	Effects.to_alpha(th,0)
	yield(get_tree().create_timer(.6),"timeout")
	unit.damage(1)
	yield(get_tree().create_timer(.3),"timeout")
	th.visible = false
	th.modulate.a = 1
	yield(get_tree().create_timer(.3),"timeout")
	emit_signal("end_magic")
