extends Node

var card_descriptor
var hand_cards = [null,null,null,null,null]
var DeckNode
var DiscardNode
var HandBoxNode
var TempGoldNode
var Cards = [
	{"code":"militia", "ico":null, "cost":4, "burn":true},
	{"code":"soldier", "ico":null, "cost":5,"burn":true},
	{"code":"market", "ico":null, "cost":4, "burn":true},
	{"code":"wind", "ico":null, "cost":2, "burn":true},
	{"code":"gold1", "ico":null, "cost":0, "burn":false},
	{"code":"gold2", "ico":null, "cost":0, "burn":false},
	{"code":"teasure", "ico":null, "cost":0, "burn":true},
	{"code":"house", "ico":null, "cost":4, "burn":true},
	{"code":"advance", "ico":null, "cost":4, "burn":true},
	{"code":"thundre", "ico":null, "cost":4, "burn":true},
	{"code":"chest", "ico":null, "cost":0, "burn":true},
	{"code":"heal", "ico":null, "cost":3, "burn":true},
	{"code":"explode", "ico":null, "cost":6, "burn":true},
	{"code":"train", "ico":null, "cost":3, "burn":true},
	{"code":"torment", "ico":null, "cost":6, "burn":true},
]

signal use_card(code)
signal burn_card(code)

func _ready():
	#INITIALIZE CARDS
	for c in Cards: c["ico"] = load("res://assets/ico_cards/"+c["code"]+".png")

func init_card_manager():
	hand_cards = [null,null,null,null,null]

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
	#print("DECK TO HAND")
	for i in range(hand_cards.size()):
		if hand_cards[i]: continue
		else:
			#print("CREATE NEW CARD")
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
		yield(get_tree().create_timer(.2),"timeout")
		if(DeckNode.cards.size()<=0):
			yield(get_tree().create_timer(.7),"timeout")
			var start_discard_pos = DiscardNode.rect_global_position
			Effects.move_to(DiscardNode,DeckNode.rect_global_position) 
			yield(get_tree().create_timer(.5),"timeout")
			DeckNode.set_card_array( DiscardNode.get_all_cards() )
			DiscardNode.rect_global_position = start_discard_pos
			yield(get_tree().create_timer(.3),"timeout")
	yield(get_tree().create_timer(.4),"timeout")
	Global.set_stop_mouse(false)

func use_card(card_node):
	Global.set_stop_mouse(true)
	if card_node.data.cost>TempGoldNode.gold:
		yield(get_tree().create_timer(.3),"timeout")
		TempGoldNode.show_low_gold()
		yield(get_tree().create_timer(.4),"timeout")
	else:
		var code = card_node.data.code
		var conditions_ok = true
		if(CardUsage.has_method("condition_card_"+code)): 
			conditions_ok = CardUsage.call("condition_card_"+code,card_node)
		if(conditions_ok && CardUsage.has_method("use_card_"+code)): 
				TempGoldNode.add_gold(-card_node.data.cost)
				Effects.move_to(card_node,card_node.rect_global_position+Vector2(0,-40))
				Sounds.play_sound("card2")
				yield(get_tree().create_timer(.2),"timeout")
				CardUsage.call("use_card_"+code,card_node)
				yield(CardUsage,"end_usage")
				yield(get_tree().create_timer(.2),"timeout")
				Effects.disappear(card_node,Vector2(0,-20))
				hand_cards[hand_cards.find(card_node)] = null
				DiscardNode.add_card(code)
	yield(get_tree().create_timer(.4),"timeout")
	Global.set_stop_mouse(false)

func burn_card(card_node):
	Global.set_stop_mouse(true)
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
			break
	Global.set_stop_mouse(false)
