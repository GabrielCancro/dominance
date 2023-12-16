extends Node

signal end_usage

func _ready():
	pass # Replace with function body.

#Todos los usos deben demorar al menos 0.1, sino se bloquea el manager de cartas
func condition_card_soldier(card_node):
	var cn_units = get_node("/root/Game/Map").get_units_amount_team(1)
	var cn_houses = get_node("/root/Game/Houses").amount
	if(cn_units<cn_houses): 
		return true
	else: 
		get_node("/root/Game/Houses").show_low_house()
		return false
	
func use_card_soldier(card_node):
	Global.set_stop_mouse(false)
	get_node("/root/Game/Map").show_create_unit_ui(card_node.data.code)
	yield(get_node("/root/Game/Map"),"unit_created")
	Global.set_stop_mouse(true)
	emit_signal("end_usage")

func condition_card_militia(card_node):
	return condition_card_soldier(card_node)

func use_card_militia(card_node):
	use_card_soldier(card_node)

func use_card_gold1(card_node):
	get_node("/root/Game/RegionBottom/TempGold").add_gold(1)
	yield(get_tree().create_timer(.1),"timeout")
	emit_signal("end_usage")

func use_card_gold2(card_node):
	get_node("/root/Game/RegionBottom/TempGold").add_gold(2)
	yield(get_tree().create_timer(.1),"timeout")
	emit_signal("end_usage")

func use_card_market(card_node):
	get_node("/root/Game/Market").show_market()
	yield(get_tree().create_timer(.1),"timeout")
	emit_signal("end_usage")

func use_card_teasure(card_node):
	get_node("/root/Game/RegionBottom/Stash").add_stash_gold(1)
	yield(get_tree().create_timer(.3),"timeout")
	emit_signal("end_usage")

func use_card_wind(card_node):
	yield(get_tree().create_timer(.4),"timeout")
	randomize()
	for u in get_node("/root/Game/Map/Units").get_children():
		if u.data.team==1: continue
		Effects.shine(u)
		yield(get_tree().create_timer(.4),"timeout")
		if(randf()>.5): get_node("/root/Game/Map").move_to(u,u.map_position+Vector2(1,0))
		yield(get_tree().create_timer(.4),"timeout")
	yield(get_tree().create_timer(.4),"timeout")
	emit_signal("end_usage")

func condition_card_advance(card_node):
	if get_node("/root/Game/Map").get_units_amount_team(1)<=0:
		Sounds.play_sound("fail1")
		return false
	else: return true

func use_card_advance(card_node):
	var mapNode = get_node("/root/Game/Map")
	Global.set_stop_mouse(false)
	mapNode.show_select_unit_panel(1)
	var unit = yield(mapNode,"selected_unit")
	Global.set_stop_mouse(true)
	Effects.shine(unit)
	yield(get_tree().create_timer(.7),"timeout")
	var moved = mapNode.move_to(unit,unit.map_position+Vector2(1,0))
	if moved: yield(get_tree().create_timer(.4),"timeout")
	mapNode.unit_try_attack(unit)
	yield(get_tree().create_timer(.7),"timeout")
	emit_signal("end_usage")

func condition_card_thundre(card_node):
	if get_node("/root/Game/Map").get_units_amount_team(2)<=0:
		Sounds.play_sound("fail1")
		return false
	return true

func use_card_thundre(card_node):
	var mapNode = get_node("/root/Game/Map")
	Global.set_stop_mouse(false)
	mapNode.show_select_unit_panel(2)
	var unit = yield(mapNode,"selected_unit")
	Global.set_stop_mouse(true)
	Global.magic_thundre(unit)
	yield(Global,"end_magic")
	emit_signal("end_usage")

func condition_card_house(card_node):
	if get_node("/root/Game/Houses").is_max():
		get_node("/root/Game/Houses").show_max_house()
		return false
	else: return true

func use_card_house(card_node):
	get_node("/root/Game/Houses").add_house()
	yield(get_tree().create_timer(.3),"timeout")
	emit_signal("end_usage")

func use_card_chest(card_node):
	var gold = 0
	yield(get_tree().create_timer(.4),"timeout")
	for i in CardData.hand_cards.size():
		var c = CardData.hand_cards[i]
		if c==null: continue 
		if !is_instance_valid(c): continue
		if c==card_node: continue
		CardData.DiscardNode.add_card(c.data.code)
		Effects.disappear(c,Vector2(0,30))
		CardData.hand_cards[i] = null
		yield(get_tree().create_timer(.2),"timeout")
		get_node("/root/Game/RegionBottom/Stash").add_stash_gold(1)
	yield(get_tree().create_timer(.2),"timeout")
	emit_signal("end_usage")

func condition_card_heal(card_node):
	if get_node("/root/Game/Map").get_units_amount_team(1)<=0:
		Sounds.play_sound("fail1")
		return false
	return true

func use_card_heal(card_node):
	var mapNode = get_node("/root/Game/Map")
	Global.set_stop_mouse(false)
	mapNode.show_select_unit_panel(1)
	var unit = yield(mapNode,"selected_unit")
	Global.set_stop_mouse(true)
	Effects.shine(unit)
	yield(get_tree().create_timer(.3),"timeout")
	unit.add_hp(1)
	yield(get_tree().create_timer(.7),"timeout")
	emit_signal("end_usage")
