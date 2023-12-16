extends Node

signal end_apply_upgrades

var UPGRADES = {
	"upg1":{"texture":preload("res://assets/ico_cards/chest.png"),"cost":20},
	"upg2":{"texture":preload("res://assets/ico_cards/thundre.png"),"cost":35},
	"upg3":{"texture":preload("res://assets/ico_cards/house.png"),"cost":20},
	"upg4":{"texture":preload("res://assets/ico_cards/heal.png"),"cost":25},
	"upg5":{"texture":preload("res://assets/ico_cards/militia.png"),"cost":20},
	"upg6":{"texture":preload("res://assets/ico_cards/teasure.png"),"cost":25},
	"upg7":{"texture":preload("res://assets/ico_cards/market.png"),"cost":35},
	"upg8":{"texture":preload("res://assets/ico_cards/soldier.png"),"cost":35},
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

func apply_upgrades():
	for u in Saves.savedData.upgrades:
		print("CHECK "+u)
		if has_method("apply_"+u): 
			print("APPLY "+u)
			call("apply_"+u)
			yield(get_tree().create_timer(.3),"timeout")
	yield(get_tree().create_timer(.2),"timeout")
	emit_signal("end_apply_upgrades")

func apply_upg1():
	get_node("/root/Game/RegionBottom/Stash").add_stash_gold(5)

func apply_upg2():
	CardData.get_card_data("thundre").cost = 3

func apply_upg3():
	get_node("/root/Game/Houses").add_house()

func apply_upg4():
	get_node("/root/Game/RegionBottom/Deck").add_card("heal",true)

func apply_upg5():
	CardData.get_card_data("militia").cost = 3

func apply_upg6():
	pass

func apply_upg7():
	CardData.get_card_data("market").cost = 3

func apply_upg8():
	CardData.get_card_data("soldier").cost = 4
