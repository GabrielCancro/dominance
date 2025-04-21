extends Node

signal end_usage

func _ready():
	pass # Replace with function body.

#Todos los usos deben demorar al menos 0.1, sino se bloquea el manager de cartas
func warning_card_soldier(card_node):
	var h = get_node("/root/Game/Houses").amount
	var u = get_node("/root/Game/Houses").units
	if u>=h: card_node.set_warning("need_houses")
	else: card_node.set_warning(null)

func condition_card_soldier(card_node):
	var cn_units = get_node("/root/Game/Map").get_units_amount_team(1)
	var cn_houses = get_node("/root/Game/Houses").amount
	if(cn_units<cn_houses): 
		return true
	else: 
		get_node("/root/Game/Houses").show_low_house()
		return false
	
func use_card_soldier(card_node):
	var CUP = get_node("/root/Game/CreateUnitPanel")
	CUP.show_ui(card_node.data.code)
	yield(CUP,"close")
	emit_signal("end_usage")

func warning_card_militia(card_node):
	var h = get_node("/root/Game/Houses").amount
	var u = get_node("/root/Game/Houses").units
	if u>=h: card_node.set_warning("need_houses")
	else: card_node.set_warning(null)

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
	get_node("/root/Game/RegionBottom/Stash").add_stash_gold(2)
	yield(get_tree().create_timer(.4),"timeout")
	emit_signal("end_usage")

func use_card_wind(card_node):
	yield(get_tree().create_timer(.4),"timeout")
	randomize()
	for u in get_node("/root/Game/Map/Units").get_children():
		if u.data.team==1: continue
		if u.map_position.x>=LevelManager.current_level_data.grid_size: continue
		if get_node("/root/Game/Map").check_unit_pos(u.map_position+Vector2(1,0)): continue
		if(randf()<.25): continue
		Effects.shine(u)
		var th = load("res://prefabs/magics/MagicWind.tscn").instance()
		get_node("/root/Game/Map").add_child(th)
		th.start_magic(u)
		yield(get_tree().create_timer(.4),"timeout")
		get_node("/root/Game/Map").move_to(u,u.map_position+Vector2(1,0))
		yield(get_tree().create_timer(.4),"timeout")
		if(randf()<.50): 
			get_node("/root/Game/Map").move_to(u,u.map_position+Vector2(1,0))
			yield(get_tree().create_timer(.4),"timeout")
	yield(get_tree().create_timer(.4),"timeout")
	emit_signal("end_usage")

func condition_card_advance(card_node):
	if get_node("/root/Game/Map").get_units_amount_team(1)<=0:
		Sounds.play_sound("fail1")
		return false
	else: return true

func use_card_advance(card_node):
	var SelectUnitPanel = get_node("/root/Game/SelectUnitPanel")
	var mapNode = get_node("/root/Game/Map")
	SelectUnitPanel.show_ui(["ally"])
	var unit = yield(SelectUnitPanel,"selected_unit")
	unit.have_attack = true
	Effects.shine(unit)
	yield(get_tree().create_timer(.7),"timeout")
	var moved = mapNode.move_to(unit,unit.map_position+Vector2(1,0))
	if moved: yield(get_tree().create_timer(.4),"timeout")
	var enemy = mapNode.unit_try_attack(unit)
	enemy.have_attack = false
	yield(get_tree().create_timer(.7),"timeout")
	emit_signal("end_usage")

func condition_card_thundre(card_node):
	if get_node("/root/Game/Map").get_units_amount_team(2)<=0:
		Sounds.play_sound("fail1")
		return false
	return true

func use_card_thundre(card_node):
	var SelectUnitPanel = get_node("/root/Game/SelectUnitPanel")
	var mapNode = get_node("/root/Game/Map")
	SelectUnitPanel.show_ui(["enemy"])
	var unit = yield(SelectUnitPanel,"selected_unit")
	var th = load("res://prefabs/magics/MagicThundre.tscn").instance()
	mapNode.add_child(th)
	th.start_magic(unit)
	yield(th,"end_magic")
	emit_signal("end_usage")

func warning_card_house(card_node):
	if get_node("/root/Game/Houses").is_max():
		card_node.set_warning("max_houses")
	else: 
		card_node.set_warning(null)

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
	var map = get_node("/root/Game/Map")
	if !map.have_any_ally_without_max_heal():
		Sounds.play_sound("fail1")
		return false
	return true

func use_card_heal(card_node):
	var SelectUnitPanel = get_node("/root/Game/SelectUnitPanel")
	var mapNode = get_node("/root/Game/Map")
	SelectUnitPanel.show_ui(["ally","damaged"])
	var unit = yield(SelectUnitPanel,"selected_unit")
	Effects.shine(unit)
	Sounds.play_sound("healt1")
	yield(get_tree().create_timer(.3),"timeout")
	unit.add_hp(min(2,unit.data.hpm-unit.data.hp))
	yield(get_tree().create_timer(.7),"timeout")
	emit_signal("end_usage")

func condition_card_explode(card_node):
	if get_node("/root/Game/Map").get_units_amount_team(2)<=0:
		Sounds.play_sound("fail1")
		return false
	return true
	
func use_card_explode(card_node):
	var SelectUnitPanel = get_node("/root/Game/SelectUnitPanel")
	var mapNode = get_node("/root/Game/Map")
	SelectUnitPanel.show_ui(["enemy"])
	var unit = yield(SelectUnitPanel,"selected_unit")
	var th = load("res://prefabs/magics/MagicFire.tscn").instance()
	mapNode.add_child(th)
	th.start_magic(unit)
	yield(th,"end_magic")
	emit_signal("end_usage")

func condition_card_train(card_node): 
	return get_node("/root/Game/Map").have_militias()

func use_card_train(card_node):
	var SelectUnitPanel = get_node("/root/Game/SelectUnitPanel")
	var mapNode = get_node("/root/Game/Map")
	SelectUnitPanel.show_ui(["militia"])
	var unit = yield(SelectUnitPanel,"selected_unit")
	var pos = unit.map_position
	yield(get_tree().create_timer(.3),"timeout")
	Effects.to_alpha(unit,0)
	yield(get_tree().create_timer(.8),"timeout")
	unit.queue_free()
	yield(get_tree().create_timer(.2),"timeout")
	Sounds.play_sound("unit1")
	var new_unit = get_node("/root/Game/Map").add_unit("soldier",pos.x,pos.y)
	Effects.shine(new_unit)
	yield(get_tree().create_timer(.6),"timeout")
	emit_signal("end_usage")

func condition_card_torment(card_node):
	if get_node("/root/Game/Map").get_units_amount_team(2)<=0:
		Sounds.play_sound("fail1")
		return false
	return true

func use_card_torment(card_node):
	var enemies = []
	for u in get_node("/root/Game/Map/Units").get_children():
		if u.data.team!=1: enemies.append(u)
	var mapNode = get_node("/root/Game/Map")
	enemies.shuffle()
	for i in range(3):
		yield(get_tree().create_timer(.2),"timeout")
		var th = load("res://prefabs/magics/MagicThundre.tscn").instance()
		mapNode.add_child(th)
		th.start_magic(enemies.pop_front())
		yield(get_tree().create_timer(.3),"timeout")
		if enemies.size()<=0: break
	yield(get_tree().create_timer(.4),"timeout")
	emit_signal("end_usage")

func condition_card_cobweb(card_node): return true
func use_card_cobweb(card_node): 
	yield(get_tree().create_timer(.4),"timeout")
	emit_signal("end_usage")

func condition_card_train_arc(card_node):
	return get_node("/root/Game/Map").have_militias()

func use_card_train_arc(card_node):
	var SelectUnitPanel = get_node("/root/Game/SelectUnitPanel")
	var mapNode = get_node("/root/Game/Map")
	SelectUnitPanel.show_ui(["militia"])
	var unit = yield(SelectUnitPanel,"selected_unit")
	var pos = unit.map_position
	yield(get_tree().create_timer(.3),"timeout")
	Effects.to_alpha(unit,0)
	yield(get_tree().create_timer(.8),"timeout")
	unit.queue_free()
	yield(get_tree().create_timer(.2),"timeout")
	Sounds.play_sound("unit1")
	var new_unit = get_node("/root/Game/Map").add_unit("archer",pos.x,pos.y)
	Effects.shine(new_unit)
	yield(get_tree().create_timer(.6),"timeout")
	emit_signal("end_usage")
