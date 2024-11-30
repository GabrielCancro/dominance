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
	set_warning()

func set_data(_code):
	data = CardData.get_card_data(_code)
	$Title.text = Lang.get_card_name(_code)
	$Ico.texture = data.ico
	
#	$GoldBox.visible = (data.cost<5)
#	if $GoldBox.visible:
#		for g in $GoldBox.get_children():
#			g.visible = (g.get_index()<data.cost)
#		$GoldBox.add_constant_override ("separation", -1)
#		if data.cost>=4: $GoldBox.add_constant_override ("separation", -7)
	$CostGold.visible = (data.cost>0)
	$CostGold/Cost.text = str(data.cost)
	
	$BurnArea.visible = data.burn
	$BurnIco.visible = data.burn
	$BurnIco2.visible = data.burn

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
	if !is_usable || !$BorderColor.visible: return
	CardData.use_card(self)

func on_click_burn():
	if !is_usable: return
	CardData.burn_card(self)

func set_enable_card(val):
	$DisableMouse.visible = !val

func set_usable_card(val):
	is_usable = val

func set_warning(text_code=null):
	$Warning.visible = (text_code!=null)
	if $Warning.visible: $Warning.text = Lang.get_string(text_code)

func animate_burn():
	$DisableMouse.visible = true
	$BurnAnimSprite.play("default")
	$BurnAnimSprite.playing = true
	$BurnAnimSprite.visible = true
	yield(get_tree().create_timer(.2),"timeout")
	Sounds.play_sound("burn1")
	yield($BurnAnimSprite,"animation_finished")
	$Ico.visible = false
	$CardFront.visible = false
	$Title.visible = false
	$CostGold.visible = false
	$BurnIco.visible = false
	$BurnIco2.visible = false
	$Warning.visible = false
	Effects.to_alpha(self,0)
