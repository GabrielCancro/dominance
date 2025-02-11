extends Control

var unit_code
signal close

func _ready():
	visible = false
	$btn1.connect("button_down",self,"select_line",[1])
	$btn2.connect("button_down",self,"select_line",[2])
	$btn3.connect("button_down",self,"select_line",[3])
	$AnimationPlayer.play("idle")

func show_ui(_code):
	unit_code = _code
	var xpos = get_node("/root/Game/Map").get_first_cell_x_position()
	$btn1.rect_global_position.x = xpos - 20
	$btn2.rect_global_position.x = xpos - 20
	$btn3.rect_global_position.x = xpos - 20
	modulate.a = 0
	visible = true
	Effects.to_alpha(self,1)
	yield(get_tree().create_timer(.2),"timeout")
	Global.set_stop_mouse(false)

func select_line(line):
	print("AAAS")
	get_node("/root/Game/Map").create_unit_left(line,unit_code)
	hide_ui()

func hide_ui():
	visible = false
	Global.set_stop_mouse(true)
	emit_signal("close")
