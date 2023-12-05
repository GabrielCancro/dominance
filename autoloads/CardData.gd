extends Node

var card_descriptor
var hand_cards = [null,null,null,null,null]
var DeckNode
var DiscardNode
var HandBoxNode
var TempGoldNode
var Cards = [
	{"code":"soldier", "ico":null, "cost":2, "title":"Soldado", "burn":true},
	{"code":"warrior", "ico":null, "cost":4, "title":"Guerrero", "burn":true},
	{"code":"market", "ico":null, "cost":4, "title":"Mercado", "burn":true},
	{"code":"wind", "ico":null, "cost":2, "title":"Vendabal", "burn":true},
	{"code":"gold", "ico":null, "cost":0, "title":"Oro", "burn":false},
]

signal use_card(code)
signal burn_card(code)

func _ready():
	#INITIALIZE CARDS
	for c in Cards: c["ico"] = load("res://assets/ico_cards/"+c["code"]+".png")

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

func _card_deck_to_hand():
	print("DECK TO HAND")
	for i in range(hand_cards.size()):
		if hand_cards[i]: continue
		else:
			print("CREATE NEW CARD")
			Sounds.play_sound("card1")
			var new_card = preload("res://prefabs/Card.tscn").instance()
			get_node("/root/Game/RegionBottom").add_child(new_card)
			new_card.rect_global_position = DeckNode.rect_global_position
			new_card.set_data( DeckNode.pull_card() )
			hand_cards[i] = new_card
			Effects.move_to(new_card,HandBoxNode.get_child(i).rect_global_position)
			return new_card
	return null

func get_cards():
	while _card_deck_to_hand():
		if(DeckNode.cards.size()<=0): 
			yield(get_tree().create_timer(1),"timeout")
			var size = DiscardNode.cards.size()
			for i in size: 
				DeckNode.add_card( DiscardNode.pull_card() )
				yield(get_tree().create_timer(.2),"timeout")
			DeckNode.cards.shuffle()
			yield(get_tree().create_timer(1),"timeout")
		yield(get_tree().create_timer(.2),"timeout")

func use_card(card_node):
	if card_node.data.cost>TempGoldNode.gold:
		TempGoldNode.show_low_gold()
		return
	for i in range(hand_cards.size()):
		if hand_cards[i]!=card_node: continue
		else:
			TempGoldNode.add_gold(-card_node.data.cost)
			card_node.set_enable_card(false)
			var code = card_node.data.code
			Effects.disappear(card_node,Vector2(0,-50))
			Sounds.play_sound("card2")
			yield(get_tree().create_timer(.4),"timeout")
			hand_cards[i] = null
			if(CardUsage.has_method("use_card_"+code)): CardUsage.call("use_card_"+code,code)
			else: CardUsage.use_default_card(code)
			DiscardNode.add_card(code)
			return null

func burn_card(card_node):
	card_node.set_enable_card(false)
	for i in range(hand_cards.size()):
		if hand_cards[i]!=card_node: continue
		else:
			Sounds.play_sound("burn1")
			DiscardNode.add_card(card_node.data.code)
			Effects.disappear(card_node,Vector2(0,30))
			hand_cards[i] = null
			emit_signal("burn_card")
			yield(get_tree().create_timer(.3),"timeout")
			TempGoldNode.add_gold(1)
			return null
