extends Control

var tags = [] #ally,enemy,damaged
signal selected_unit(unit)

func _ready():
	visible = false
	get_node("/root/Game/Map").connect("unit_clicked",self,"on_unit_clicked")

func show_ui(_tags=[]):
	modulate.a = 0
	visible = true
	Effects.to_alpha(self,1)
	yield(get_tree().create_timer(.2),"timeout")
	Global.set_stop_mouse(false)
	tags = _tags
	$Label.text = Lang.get_string("select_target")

func on_unit_clicked(unit):
	print(unit.data)
	if !visible: return
	for t in tags:
		if t=="ally" && unit.data.team!=1: return false
		if t=="enemy" && unit.data.team!=2: return false
		if t=="damaged" && unit.data.hp>=unit.data.hpm: return false
	emit_signal("selected_unit",unit)
	hide_ui()

func hide_ui():
	visible = false
	Global.set_stop_mouse(true)
	emit_signal("close")
