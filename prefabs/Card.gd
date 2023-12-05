extends Control

var data
var is_usable = true

func _ready():
	set_data("soldier")
	$CardArea.connect("mouse_entered",self,"on_mouse_enter")
	$CardArea.connect("mouse_exited",self,"on_mouse_exit")
	$CardArea.connect("button_down",self,"on_click_card")
	$BurnArea.connect("mouse_entered",self,"on_mouse_burn_enter")
	$BurnArea.connect("mouse_exited",self,"on_mouse_burn_exit")
	$BurnArea.connect("button_down",self,"on_click_burn")
	$BurnColor.visible = false
	$BorderColor.visible = false

func set_data(_code):
	data = CardData.get_card_data(_code)
	$Title.text = data.title
	$Ico.texture = data.ico
	for g in $GoldBox.get_children():
		g.visible = (g.get_index()<data.cost)
	$GoldBox.add_constant_override ("separation", -1)
	if data.cost>=4: $GoldBox.add_constant_override ("separation", -7)
	if data.cost>=5: $GoldBox.add_constant_override ("separation", -8)
	if data.cost>=6: $GoldBox.add_constant_override ("separation", -9)
	
	$BurnArea.visible = data.burn
	$BurnIco.visible = data.burn

func on_mouse_enter():
	CardData.show_card_description(self)
	$BorderColor.visible = true

func on_mouse_exit():
	CardData.hide_card_description(self)
	$BorderColor.visible = false

func on_mouse_burn_enter():
	if !is_usable: return
	$BurnColor.visible = true
	$BorderColor.visible = true

func on_mouse_burn_exit():
	if !is_usable: return
	$BurnColor.visible = false
	$BorderColor.visible = false

func on_click_card():
	if !is_usable: return
	CardData.use_card(self)

func on_click_burn():
	if !is_usable: return
	CardData.burn_card(self)

func set_enable_card(val):
	$DisableMouse.visible = !val

func set_usable_card(val):
	is_usable = val
