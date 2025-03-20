extends Node

signal end_apply_upgrades

var UPGRADES = {
	"upg_stash":{"cost":10},
	"upg_house":{"cost":10},
	"upg_heal":{"cost":10},
	"upg_militia_gold":{"cost":15},
	"upg_gold_five_days":{"cost":10},
	"upg_thundre_gold":{"cost":15},
	"upg_soldier_gold":{"cost":15},
	"upg_market_gold":{"cost":15},
	"upg_magics":{"cost":15},
	"upg_train":{"cost":15},
	"upg_train_arc":{"cost":15},
	"upg_chest":{"cost":10},
}

func add_upgrade(code):
	Saves.savedData.upgrades.append(code)
	Saves.save_store_data()

func get_non_obtained_upgrades():
	var arr = UPGRADES.keys().duplicate()
	for k in Saves.savedData.upgrades_unlocked: arr.erase(k)
	return arr

func get_one_non_obtained_upgrade():
	var arr = get_non_obtained_upgrades()
	arr.shuffle()
	if arr.size()<=0: return null
	else: return arr[0]

func get_upg_data(code):
	var data = UPGRADES[code]
	data["desc"] = Lang.get_string(code)
	data["texture"] = load("res://assets/upgrades/"+code+".jpg")
	return data

func get_amount_unobtained():
	return UPGRADES.keys().size()-get_non_obtained_upgrades().size()

func apply_upgrades():
	for u in LevelManager.current_upgrades:
		print("CHECK "+u)
		if has_method("apply_"+u): 
			print("APPLY "+u)
			call("apply_"+u)
			yield(get_tree().create_timer(.3),"timeout")
	yield(get_tree().create_timer(.2),"timeout")
	emit_signal("end_apply_upgrades")

func apply_upg_stash():
	get_node("/root/Game/RegionBottom/Stash").add_stash_gold(5)

func apply_upg_thundre_gold():
	CardData.get_card_data("thundre").cost = 3

func apply_upg_house():
	get_node("/root/Game/Houses").add_house()

func apply_upg_heal():
	get_node("/root/Game/RegionBottom/Deck").add_card("heal",true)

func apply_upg_militia_gold():
	CardData.get_card_data("militia").cost = 3

func apply_upg_gold_five_days():
	pass

func apply_upg_market_gold():
	CardData.get_card_data("market").cost = 3

func apply_upg_soldier_gold():
	CardData.get_card_data("soldier").cost = 4

func apply_upg_magics():
	get_node("/root/Game/Market").market_cards.append("torment")
	get_node("/root/Game/Market").market_cards.append("explode")

func apply_upg_train():
	get_node("/root/Game/RegionBottom/Deck").add_card("train",true)

func apply_upg_train_arc():
	get_node("/root/Game/RegionBottom/Deck").add_card("train_arc",true)

func apply_upg_chest():
	get_node("/root/Game/RegionBottom/Deck").cards.erase("teasure")
	get_node("/root/Game/RegionBottom/Deck").add_card("chest",true)
