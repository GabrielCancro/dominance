extends Button

var code
var chossen = false
var hover = false
signal on_select(node)

func _ready():
	set_chossen(false)
	connect("button_down",self,"on_click")

func set_data(_code):
	code = _code
	$ico.texture = UpgradeData.get_upg_data(_code).texture

func set_hover(val):
	hover = val
	$ColorRect.visible = val	

func set_chossen(val):
	chossen = val
	$bg_shine.visible = val
	$romb2.visible = val
	if val: $ico.modulate = Color(1,1,1,1)
	else: $ico.modulate = Color(.6,.6,.6,1)
	#$bg.modulate = Color(1,1,.7,1)

func on_click():
	#if(!$ColorRect.visible): return
	print("UPGRADE CLICK")
	emit_signal("on_select",self)
