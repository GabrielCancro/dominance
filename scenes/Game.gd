extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$RegionBottom/Deck.connect("button_down",self,"on_click_deck")
	CardData.DeckNode = $RegionBottom/Deck
	CardData.HandBoxNode = $RegionBottom/HandCards
	CardData.TempGoldNode = $RegionBottom/TempGold

func on_click_deck():
	CardData.card_deck_to_hand()
