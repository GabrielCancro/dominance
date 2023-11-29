extends TextureRect

var data

func _ready():
	set_data("soldier")
	$CardArea.connect("mouse_entered",self,"on_mouse_enter")
	$CardArea.connect("mouse_exited",self,"on_mouse_exit")
	$BurnArea.connect("mouse_entered",self,"on_mouse_burn_enter")
	$BurnArea.connect("mouse_exited",self,"on_mouse_burn_exit")
	$BurnColor.visible = false
	on_mouse_exit()

func set_data(_code):
	data = CardData.get_card_data(_code)
	data = CardData.get_rnd_card()
	$Title.text = data.title
	$Ico.texture = data.ico
	for g in $GoldBox.get_children():
		g.visible = (g.get_index()<data.cost)
	$GoldBox.add_constant_override ("separation", -1)
	if data.cost>=4: $GoldBox.add_constant_override ("separation", -7)
	if data.cost>=5: $GoldBox.add_constant_override ("separation", -8)
	if data.cost>=6: $GoldBox.add_constant_override ("separation", -9)

func on_mouse_enter():
	print("ENTER ON CARD ",data.code)
	CardData.show_card_description(self)
	modulate = Color(1,1,1,1)

func on_mouse_exit():
	print("EXIT FROM CARD ",data.code)
	CardData.hide_card_description(self)
	modulate = Color(.6,.6,.7,1)

func on_mouse_burn_enter():
	$BurnColor.visible = true
	modulate = Color(1,1,1,1)

func on_mouse_burn_exit():
	$BurnColor.visible = false
	modulate = Color(.6,.6,.7,1)
