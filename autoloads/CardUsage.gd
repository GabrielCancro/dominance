extends Node

signal end_usage

func _ready():
	pass # Replace with function body.

#Todos los usos deben demorar al menos 0.1, sino se bloquea el manager de cartas
func condition_card_soldier(code):
	var cn_units = get_node("/root/Game/Map").get_units_amount_team(1)
	var cn_houses = get_node("/root/Game/Houses").amount
	if(cn_units<cn_houses): 
		return true
	else: 
		get_node("/root/Game/Houses").show_low_house()
		return false
	
func use_card_soldier(code):
	Global.set_stop_mouse(false)
	get_node("/root/Game/Map").show_create_unit_ui(code)
	yield(get_node("/root/Game/Map"),"unit_created")
	Global.set_stop_mouse(true)
	emit_signal("end_usage")

func condition_card_militia(code):
	return condition_card_soldier("militia")

func use_card_militia(code):
	use_card_soldier("militia")

func use_card_gold(code):
	get_node("/root/Game/RegionBottom/TempGold").add_gold(2)
	yield(get_tree().create_timer(.3),"timeout")
	emit_signal("end_usage")

func use_card_market(code):
	get_node("/root/Game/Market").show_market()
	yield(get_tree().create_timer(.3),"timeout")
	emit_signal("end_usage")

func use_card_teasure(code):
	get_node("/root/Game/RegionBottom/Stash").add_stash_gold(1)
	yield(get_tree().create_timer(.3),"timeout")
	emit_signal("end_usage")

func use_card_wind(code):
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

func condition_card_advance(code):
	if get_node("/root/Game/Map").get_units_amount_team(1)<=0:
		Sounds.play_sound("fail1")
		return false
	else: return true

func use_card_advance(code):
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

func contidiot_card_thundre(code):
	if get_node("/root/Game/Map").get_units_amount_team(2)<=0:
		Sounds.play_sound("fail1")
		return false
	return true

func use_card_thundre(code):
	var mapNode = get_node("/root/Game/Map")
	Global.set_stop_mouse(false)
	mapNode.show_select_unit_panel(2)
	var unit = yield(mapNode,"selected_unit")
	Global.set_stop_mouse(true)
	yield(get_tree().create_timer(.3),"timeout")
	var th = mapNode.get_node("Thundre")
	th.rect_position = unit.rect_position
	yield(get_tree().create_timer(.2),"timeout")
	th.visible = true
	Sounds.play_sound("thundre1")
	Effects.shine(unit)
	Effects.shine(th)
	Effects.shake(th)
	yield(get_tree().create_timer(.3),"timeout")
	Effects.to_alpha(th,0)
	yield(get_tree().create_timer(.6),"timeout")
	unit.damage(1)
	yield(get_tree().create_timer(.3),"timeout")
	th.visible = false
	th.modulate.a = 1
	yield(get_tree().create_timer(.3),"timeout")
	emit_signal("end_usage")
	
func use_card_house(code):
	get_node("/root/Game/Houses").add_house()
	yield(get_tree().create_timer(.3),"timeout")
	emit_signal("end_usage")
