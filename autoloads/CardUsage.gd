extends Node

func _ready():
	pass # Replace with function body.

func use_card_soldier(code):
	var cn_units = get_node("/root/Game/Map").get_units_amount_team(1)
	var cn_houses = get_node("/root/Game/Houses").amount
	if(cn_units<cn_houses):
		get_node("/root/Game/Map").show_create_unit_ui("soldier")
		return true
	else: 
		get_node("/root/Game/Houses").show_low_house()
		return false

func use_card_gold(code):
	get_node("/root/Game/RegionBottom/TempGold").add_gold(2)
	return true

func use_card_market(code):
	get_node("/root/Game/Market").show_market()
	return true

func use_card_warrior(code):
	return use_card_soldier("soldier")

func use_card_teasure(code):
	get_node("/root/Game/RegionBottom/Stash").add_stash_gold(1)
	return true

func use_card_wind(code):
	Global.set_stop_mouse(true)
	yield(get_tree().create_timer(.4),"timeout")
	randomize()
	for u in get_node("/root/Game/Map/Units").get_children():
		if u.data.team==1: continue
		Effects.shine(u)
		yield(get_tree().create_timer(.4),"timeout")
		if(randf()>.5): get_node("/root/Game/Map").move_to(u,u.map_position+Vector2(1,0))
		yield(get_tree().create_timer(.4),"timeout")
	yield(get_tree().create_timer(.4),"timeout")
	Global.set_stop_mouse(false)
	return true

func use_card_house(code):
	return get_node("/root/Game/Houses").add_house()
