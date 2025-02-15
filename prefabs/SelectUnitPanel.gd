extends Control

var team_unit_to_select
signal selected_unit(unit)

func _ready():
	visible = false
	get_node("/root/Game/Map").connect("unit_clicked",self,"on_unit_clicked")

func show_ui(team = -1):
	modulate.a = 0
	visible = true
	Effects.to_alpha(self,1)
	yield(get_tree().create_timer(.2),"timeout")
	Global.set_stop_mouse(false)
	team_unit_to_select = team
	$Label.text = Lang.get_string("select_unit_team_"+str(team))

func on_unit_clicked(unit):
	print(unit.data)
	if !visible: return
	if team_unit_to_select==-1 || unit.data.team==team_unit_to_select:
		emit_signal("selected_unit",unit)
	hide_ui()

func hide_ui():
	visible = false
	Global.set_stop_mouse(true)
	emit_signal("close")
