extends Control

signal on_close

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/Button.connect("button_down",self,"on_click_ok")


func show():
	var code = UpgradeData.get_one_non_obtained_upgrade()
	var data = UpgradeData.get_upg_data(code)
	$Control/ico.texture = data.texture
	$Control/Label.text = data.desc
	$Control/lbl_title.text = Lang.get_string("ui_upgrade_unlocked")
	modulate.a = 0
	Effects.appear_from_bottom(self)
	visible = true

func on_click_ok():
	Effects.to_alpha(self,0)
	yield(get_tree().create_timer(.5),"timeout")
	visible = false
	emit_signal("on_close")
