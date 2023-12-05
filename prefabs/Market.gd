extends Control

func _ready():
	visible = false
	get_node("Card1/CardArea").connect("button_down",self,"on_click_card",[$Card1])
	get_node("Card2/CardArea").connect("button_down",self,"on_click_card",[$Card2])
	get_node("Card3/CardArea").connect("button_down",self,"on_click_card",[$Card3])

func show_market():
	modulate.a = 0
	$Card1.set_data("soldier")
	$Card1.set_usable_card(false)
	$Card2.set_data("soldier")
	$Card2.set_usable_card(false)
	$Card3.set_data("soldier")
	$Card3.set_usable_card(false)
	visible = true
	Effects.to_alpha(self,1)

func on_click_card(card_node):
	visible = false
	card_node.on_mouse_exit()
	print("SELECT ",card_node.data.code)
