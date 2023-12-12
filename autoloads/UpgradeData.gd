extends Node

var UPGRADES = {
	"upg1":{"texture":preload("res://assets/ico_cards/chest.png")},
	"upg2":{"texture":preload("res://assets/ico_cards/thundre.png")},
	"upg3":{"texture":preload("res://assets/ico_cards/house.png")},
	"upg4":{"texture":preload("res://assets/ico_cards/heal.png")},
	"upg5":{"texture":preload("res://assets/ico_cards/militia.png")},
	"upg6":{"texture":preload("res://assets/ico_cards/teasure.png")},
	"upg7":{"texture":preload("res://assets/ico_cards/market.png")},
	"upg8":{"texture":preload("res://assets/ico_cards/soldier.png")},
}

func add_upgrade(code):
	Saves.savedData.upgrades.append(code)
	Saves.save_store_data()

func get_non_obtained_upgrades():
	var arr = UPGRADES.keys().duplicate()
	for k in Saves.savedData.upgrades:
		arr.erase(k)
	return arr

func get_upg_data(code):
	var data = UPGRADES[code]
	data["desc"] = Lang.get_string("upgrade_"+code)
	return data

func get_amount_unobtained():
	return UPGRADES.keys().size()-get_non_obtained_upgrades().size()
