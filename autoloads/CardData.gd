extends Node

var card_descriptor

var Cards = [
	{"code":"soldier", "ico":null, "cost":2, "title":"Soldado", "desc":"Invoca un soldado que defiende tu castillo"},
	{"code":"warrior", "ico":null, "cost":4, "title":"Guerrero", "desc":"Esta es otra unidad diferente"}
]

func _ready():
	#INITIALIZE CARDS
	for c in Cards: 
		c["ico"] = load("res://assets/ico_cards/"+c["code"]+".png")

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
