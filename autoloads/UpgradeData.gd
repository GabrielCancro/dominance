extends Node

var UPGRADES = {
	"upg1":{"texture":preload("res://assets/ico_cards/chest.png"),"cost":3},
	"upg2":{"texture":preload("res://assets/ico_cards/thundre.png"),"cost":3},
	"upg3":{"texture":preload("res://assets/ico_cards/house.png"),"cost":3},
	"upg4":{"texture":preload("res://assets/ico_cards/heal.png"),"cost":3},
	"upg5":{"texture":preload("res://assets/ico_cards/militia.png"),"cost":30},
	"upg6":{"texture":preload("res://assets/ico_cards/teasure.png"),"cost":30},
	"upg7":{"texture":preload("res://assets/ico_cards/market.png"),"cost":30},
	"upg8":{"texture":preload("res://assets/ico_cards/soldier.png"),"cost":30},
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
