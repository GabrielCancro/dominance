extends Button

var code
signal on_select(node)

func _ready():
	connect("button_down",self,"on_click")
	unselect()

func set_data(_code):
	code = _code
	$ico.texture = UpgradeData.get_upg_data(_code).texture

func select():
	$ColorRect.visible = true
	
func unselect():
	$ColorRect.visible = false

func turnoff():
	modulate = Color(.3,.3,.3,1)

func blu_shine():
	$bg_shine.visible = true
	$romb2.visible = true
	#$bg.modulate = Color(1,1,.7,1)

func on_click():
	#if(!$ColorRect.visible): return
	print("UPGRADE CLICK")
	emit_signal("on_select",self)
