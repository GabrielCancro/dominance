extends Button

var code

func _ready():
	pass

func set_data(_code):
	code = _code
	$ico.texture = UpgradeData.get_upg_data(_code).texture

func select():
	$ColorRect.visible = true
	
func unselect():
	$ColorRect.visible = false

func blu_shine():
	$bg.modulate = Color(1,1,.7,1)

func on_click():
	print("UPGRADE CLICK")
	emit_signal("on_select",self)
