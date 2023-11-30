extends Node

var card_descriptor
var hand_cards = [null,null,null,null,null]
var DeckNode
var HandBoxNode
var TempGoldNode
var Cards = [
	{"code":"soldier", "ico":null, "cost":2, "title":"Soldado", "desc":"Invoca un soldado que defiende tu castillo"},
	{"code":"warrior", "ico":null, "cost":4, "title":"Guerrero", "desc":"Esta es otra unidad diferente"}
]
var deck_cards = []

func _ready():
	#INITIALIZE CARDS
	for c in Cards: c["ico"] = load("res://assets/ico_cards/"+c["code"]+".png")
	for i in range(25): deck_cards.append("soldier")
	yield(get_tree().create_timer(.1),"timeout")
	DeckNode.get_node("Label").text = str( deck_cards.size() )

func get_card_data(_code):
	for c in Cards: 
		if c["code"]==_code: return c
	return null

func get_rnd_card():
	randomize()
	return Cards[ randi()%Cards.size() ]

func show_card_description(card_node):
	card_descriptor.set_target(card_node)
	card_descriptor.show_panel()

func hide_card_description(card_node):
	if card_descriptor && card_descriptor.card_target == card_node:
		card_descriptor.hide_panel()

func card_deck_to_hand():
	print("DECK TO HAND")
	for i in range(hand_cards.size()):
		if hand_cards[i]: continue
		else: 
			print("CREATE NEW CARD")
			var new_card = preload("res://prefabs/Card.tscn").instance()
			new_card.rect_global_position = DeckNode.rect_global_position
			new_card.rect_position = Vector2(0,0)
			get_node("/root/Game/RegionBottom").add_child(new_card)
			new_card.set_data( deck_cards.pop_front() )
			DeckNode.get_node("Label").text = str( deck_cards.size() )
			hand_cards[i] = new_card
			Effects.move_to(new_card,HandBoxNode.get_child(i).rect_global_position)
			return new_card

func use_card(card_node):
	if card_node.data.cost>TempGoldNode.gold:
		TempGoldNode.show_low_gold()
		return
	for i in range(hand_cards.size()):
		if hand_cards[i]!=card_node: continue
		else:
			TempGoldNode.add_gold(-card_node.data.cost)
			card_node.set_enable_card(false)
			Effects.disappear(card_node,Vector2(0,-50))
			hand_cards[i] = null
			return null

func burn_card(card_node):
	card_node.set_enable_card(false)
	for i in range(hand_cards.size()):
		if hand_cards[i]!=card_node: continue
		else:
			Effects.disappear(card_node,Vector2(0,30))
			hand_cards[i] = null
			TempGoldNode.add_gold(1)
			return null
