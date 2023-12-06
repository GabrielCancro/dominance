extends Node

signal end_use_card()

func _ready():
	pass # Replace with function body.

func use_default_card(code):
	print(code)
	emit_signal("end_use_card")

func use_card_soldier(code):
	get_node("/root/Game/Map").show_create_unit_ui("soldier")

func use_card_gold(code):
	get_node("/root/Game/RegionBottom/TempGold").add_gold(2)

func use_card_market(code):
	get_node("/root/Game/Market").show_market()

func use_card_warrior(code):
	get_node("/root/Game/Map").show_create_unit_ui("soldier")

func use_card_wind(code):
	Global.set_stop_mouse(true)
	randomize()
	for u in get_node("/root/Game/Map/Units").get_children():
		if u.data.team==1: continue
		Effects.shine(u)
		yield(get_tree().create_timer(.4),"timeout")
		if(randf()>.5): get_node("/root/Game/Map").move_to(u,u.map_position+Vector2(1,0))
		yield(get_tree().create_timer(.4),"timeout")
	Global.set_stop_mouse(false)
