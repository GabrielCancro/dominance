extends Control

var code
signal on_select(_upg)

func _ready():
	on_mouse_exited()
	$Area.connect("mouse_entered",self,"on_mouse_entered")
	$Area.connect("mouse_exited",self,"on_mouse_exited")
	$Area.connect("button_down",self,"on_click")

func set_data(_code):
	code = _code
	var data = UpgradeData.get_upg_data(_code)
	$ico.texture = data.texture
	$Upgrade/Label.text = data.desc

func on_mouse_entered():
	$Upgrade.visible = true
	$ColorRect.visible = true
	
func on_mouse_exited():
	$Upgrade.visible = false
	$ColorRect.visible = false
	
func on_click():
	print("UPGRADE CLICK")
	emit_signal("on_select",self)
