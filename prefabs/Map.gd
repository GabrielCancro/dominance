extends Control

var grid_size = Vector2(8,3)
var unit_code_to_create = ""
signal end_all_moves

func _ready():
	yield(get_tree().create_timer(.5),"timeout")
	add_unit("slime",8,1)
	add_unit("slime",7,2)
	add_unit("slime",8,3)
	$CreateButtons/btn1.connect("button_down",self,"create_unit_left",[1])
	$CreateButtons/btn2.connect("button_down",self,"create_unit_left",[2])
	$CreateButtons/btn3.connect("button_down",self,"create_unit_left",[3])
	$CreateButtons.visible = false
	$btn4.connect("button_down",self,"move_enemies")

func get_grid_node(pos):
	if pos.x<=0: return null
	if pos.y<=0: return null
	if pos.x>8: return null
	if pos.y>3: return null
	var grid_node = $Grid.get_child((pos.x-1)+(pos.y-1)*grid_size.x)
	return grid_node

func add_unit(type,x,y):
	var unit = UnitManager.create_new_unit(type)
	$Units.add_child(unit)
	unit.map_position = Vector2(x,y)
	unit.rect_global_position = get_grid_node(unit.map_position).rect_global_position
	#.get_node("EnemyArea").connect("button_down",self,"unit_walk",[unit])
	return unit

func move_to(unit,pos):
	var des = get_grid_node(pos).rect_global_position
	if des:
		Sounds.play_sound("step1")
		unit.map_position = pos
		Effects.move_to(unit,des)

func unit_try_attack(unit):
	var obj = get_unit_around(unit)
	if(obj): 
		var dest = unit.rect_global_position+(obj.rect_global_position-unit.rect_global_position)/2
		Effects.move_to_yoyo(unit,dest)
		obj.damage(unit.data.atk)
		return true
	else: return false

func unit_push(unit):
	var unit_to_push = check_unit_pos(unit.map_position,unit);
	if unit_to_push:
		if(unit_to_push.map_position.x==8): 
			unit_to_push.queue_free()
			return
		move_to(unit_to_push,unit_to_push.map_position+Vector2(1,0))
		yield(get_tree().create_timer(.2),"timeout")
		unit_push(unit_to_push);

func check_unit_pos(pos,ignoreNode=null):
	for u in $Units.get_children():
		if u!=ignoreNode && u.map_position == pos: 
			return u
	return null

func create_unit_left(line):
	var u = add_unit(unit_code_to_create,1,line);
	unit_push(u);
	Sounds.play_sound("unit1")
	$CreateButtons.visible = false

func get_unit_around(unit):
	var en = check_unit_pos(unit.map_position+Vector2(-1,0));
	if(en && unit.data.team==en.data.team): en = null
	if !en: en = check_unit_pos(unit.map_position+Vector2(+1,0));
	if(en && unit.data.team==en.data.team): en = null
	if !en: en = check_unit_pos(unit.map_position+Vector2(0,-1));
	if(en && unit.data.team==en.data.team): en = null
	if !en: en = check_unit_pos(unit.map_position+Vector2(0,+1));
	if(en && unit.data.team==en.data.team): en = null
	return en

func move_enemies():
	$btn4.visible = false
	print("+++++++++++")
	for u in $Units.get_children():
		if !is_instance_valid(u): continue
		if u.data.team==2: 
			if( unit_try_attack(u) ): 
				yield(get_tree().create_timer(.6),"timeout")
			elif u.map_position.x<=1:
				attack_tower(u)
				yield(get_tree().create_timer(.6),"timeout")
			else:
				move_to(u,u.map_position+Vector2(-1,0))
				yield(get_tree().create_timer(.2),"timeout")
	yield(get_tree().create_timer(.3),"timeout")
	move_allies()

func move_allies():
	for u in $Units.get_children():
		if u.data.team==1:
			if !is_instance_valid(u): continue
			if( unit_try_attack(u) ):
				yield(get_tree().create_timer(.6),"timeout")
	$btn4.visible = true
	emit_signal("end_all_moves")

func attack_tower(unit):
	var dest = unit.rect_global_position+($Tower.rect_global_position-unit.rect_global_position)/2
	Effects.move_to_yoyo(unit,dest)
	$Tower.damage(unit.data.atk)

func show_create_unit_ui(unit_code):
	unit_code_to_create = unit_code
	$CreateButtons.visible = true
