extends Control

var market_cards = ["gold","house","wind","teasure","soldier"]

func _ready():
	randomize()
	visible = false
	$Title.text = Lang.get_string("market")
	get_node("Card1/CardArea").connect("button_down",self,"on_click_card",[$Card1])
	get_node("Card2/CardArea").connect("button_down",self,"on_click_card",[$Card2])
	get_node("Card3/CardArea").connect("button_down",self,"on_click_card",[$Card3])

func show_market():
	modulate.a = 0
	$Card1.set_data( _get_market_rnd_card() )
	$Card1.set_usable_card(false)
	$Card2.set_data( _get_market_rnd_card() )
	$Card2.set_usable_card(false)
	$Card3.set_data( _get_market_rnd_card() )
	$Card3.set_usable_card(false)
	visible = true
	Effects.to_alpha(self,1)

func on_click_card(card_node):
	Global.set_stop_mouse(true)
	var start_pos = card_node.rect_global_position
	Effects.move_to(card_node,CardData.DiscardNode.rect_global_position)
	yield(get_tree().create_timer(.5),"timeout")
	Sounds.play_sound("card1")
	Effects.to_alpha(self,0)
	CardData.DiscardNode.add_card(card_node.data.code)
	card_node.on_mouse_exit()
	yield(get_tree().create_timer(.5),"timeout")	
	card_node.rect_global_position = start_pos
	visible = false
	Global.set_stop_mouse(false)

func _get_market_rnd_card():
	return market_cards[ randi()%market_cards.size() ]
