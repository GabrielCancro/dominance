extends Control

var market_cards = [
	"gold2","gold2",
	"soldier","soldier",
	"thundre","thundre",
	"advance","advance",
]

func _ready():
	randomize()
	visible = false
	$Title.text = Lang.get_string("market")
	get_node("HBox/Card1/CardArea").connect("button_down",self,"on_click_card",[$HBox/Card1])
	get_node("HBox/Card2/CardArea").connect("button_down",self,"on_click_card",[$HBox/Card2])
	get_node("HBox/Card3/CardArea").connect("button_down",self,"on_click_card",[$HBox/Card3])

func show_market():
	modulate.a = 0
	$HBox/Card1.visible = false
	$HBox/Card2.visible = false
	$HBox/Card3.visible = false
	market_cards.shuffle()
	print("MaRKeT ",market_cards)
	if market_cards.size()>0:
		$HBox/Card1.visible = true
		$HBox/Card1.set_data( market_cards[0] )
		$HBox/Card1.set_usable_card(false)
		$HBox/Card1.set_enable_card(true)
	if market_cards.size()>1:
		$HBox/Card2.visible = true
		$HBox/Card2.set_data( market_cards[1] )
		$HBox/Card2.set_usable_card(false)
		$HBox/Card2.set_enable_card(true)
	if market_cards.size()>2:
		$HBox/Card3.visible = true
		$HBox/Card3.set_data( market_cards[2] )
		$HBox/Card3.set_usable_card(false)
		$HBox/Card3.set_enable_card(true)
	visible = true
	Effects.to_alpha(self,1)

func on_click_card(card_node):
	if !card_node.get_node("BorderColor").visible: return
	Global.set_stop_mouse(true)
	$HBox/Card1.set_enable_card(false)
	$HBox/Card2.set_enable_card(false)
	$HBox/Card3.set_enable_card(false)
	var start_pos = card_node.rect_global_position
	Effects.move_to(card_node,CardData.DiscardNode.rect_global_position)
	yield(get_tree().create_timer(.5),"timeout")
	Sounds.play_sound("card1")
	Effects.to_alpha(self,0)
	print("CARD SELECTED ",card_node.data)
	market_cards.erase(card_node.data.code)
	print("MaRKeT ",market_cards)
	if(market_cards.size()==0): CardData.DiscardNode.cards.pop_back()
	CardData.DiscardNode.add_card(card_node.data.code)
	card_node.on_mouse_exit()
	yield(get_tree().create_timer(.5),"timeout")
	card_node.rect_global_position = start_pos
	visible = false
	Global.set_stop_mouse(false)

func _get_market_rnd_card():
	return market_cards[ randi()%market_cards.size() ]

