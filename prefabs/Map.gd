extends Control

var grid_size
var team_unit_to_select
signal end_all_moves
signal unit_clicked(unit)
signal unit_created

func _ready():
	randomize()
	grid_size = LevelManager.current_level_data.grid_size
	$Grid.columns = grid_size
	for c in $Grid.get_children(): c.visible = (c.get_index()<grid_size*3)	
#	for c in $Grid.get_children(): if c.visible: c.rect_min_size.x *= 8.0 / grid_size

	$Grid.rect_size.x = 0
	$Grid.rect_position.x += $Grid/c0.rect_size.x * 0.5 * (8-grid_size)
	if grid_size<8: $Grid.rect_position.x -= 20
	yield(get_tree().create_timer(.5),"timeout")
	LevelManager.add_debug_units()

func get_grid_node(pos):
	if pos.x<=0: return null
	if pos.y<=0: return null
	if pos.x>grid_size: return null
	if pos.y>3: return null
	var grid_node = $Grid.get_child((pos.x-1)+(pos.y-1)*grid_size)
	return grid_node

func add_unit(type,x,y):
	if x>grid_size: x=grid_size
	if check_unit_pos(Vector2(x,y),null): 
		print(" FAIL ",type,x,y)
		return null
	print(" SUCCES ",type,x,y)
	var unit = UnitManager.create_new_unit(type)
	if unit.data.team==2: Effects.fx_add_enemy(unit)
	$Units.add_child(unit)
	unit.map_position = Vector2(x,y)
	unit.rect_global_position = get_grid_node(unit.map_position).rect_global_position
	unit.get_node("UnitArea").connect("button_down",self,"on_unit_clicked",[unit])
	get_node("/root/Game/Houses")._update_houses()
	if type=="spider": get_node("/root/Game/EventsMap").add_web_card()
	return unit

func add_enemy_rnd_line(type):
	var arr = []
	var minx = grid_size
	if LevelManager.is_fog: minx = 3
	for x in range(minx,grid_size+1):
		arr.append([x,1])
		arr.append([x,2])
		arr.append([x,3])
	arr.shuffle()
	print("TRY INSERT ",type," IN POS ",arr[0])
	for i in range(arr.size()):
		if check_unit_pos(Vector2(arr[i][0],arr[i][1]),null): continue
		var xpos = grid_size
		add_unit(type,arr[i][0],arr[i][1])
		return true
	return false

func move_to(unit,pos,forced=false):
	var grid = get_grid_node(pos)
	if grid:
		if check_unit_pos(pos) && !forced: return false
		Sounds.play_sound("step1")
		unit.map_position = pos
		Effects.move_to(unit,grid.rect_global_position)
		return true
	return false

func unit_try_attack(unit):
	if !unit.have_attack: return false
	var obj = get_unit_around(unit)
	if obj: 
		swap_attacks(unit,obj)
		return true
		
	if "range" in unit.data:
		obj = get_unit_ranged(unit)
		if obj:
			range_attack(unit,obj)
			return true
	return false

func swap_attacks(ua,ub):
	var mov = (ub.rect_global_position-ua.rect_global_position)/2
	if(ua.have_attack):
		ua.have_attack = false
		Effects.move_to_yoyo(ua,ua.rect_global_position+mov)
		ub.damage(ua.data.atk,false)
		yield(get_tree().create_timer(.6),"timeout")
	if(ub.have_attack):
		ub.have_attack = false
		Effects.move_to_yoyo(ub,ub.rect_global_position-mov)
		ua.damage(ub.data.atk,false)
		yield(get_tree().create_timer(.8),"timeout")
	ub.check_dead()
	ua.check_dead()

func range_attack(ua,ub):
	print("RNGED ATTACK")
	Effects.spawn_arrow(ua,ub)
	yield(get_tree().create_timer(.2),"timeout")
	if randf()<.5: 
		yield(get_tree().create_timer(.3),"timeout")
		ub.damage(ua.data.atk,true)
	else: 
		Effects.move_to_yoyo(ub,ub.rect_global_position+Vector2(20,-10))

func unit_push(unit):
	var unit_to_push = check_unit_pos(unit.map_position,unit);
	if unit_to_push:
		if(unit_to_push.map_position.x>=grid_size): 
			unit_to_push.queue_free()
			return
		move_to(unit_to_push,unit_to_push.map_position+Vector2(1,0),true)
		yield(get_tree().create_timer(.2),"timeout")
		unit_push(unit_to_push);

func check_unit_pos(pos,ignoreNode=null):
	for u in $Units.get_children():
		if u!=ignoreNode && u.map_position == pos: 
			return u
	return null

func create_unit_left(line,code):
	var u = add_unit(code,1,line);
	unit_push(u);
	Sounds.play_sound("unit1")

func get_unit_around(unit):
	var ran = 1
	for vx in range(-ran,ran+1): 
		for vy in range(-ran,ran+1):
			var en = check_unit_pos(unit.map_position+Vector2(vx,vy));
			if !is_instance_valid(en): continue
			if en && unit.data.team==en.data.team: continue
			if en.is_dead: continue
			if unit.map_position.distance_to(en.map_position)>ran: continue
			return en
	return null

func get_unit_ranged(unit):
	var ran = unit.data["range"]
	var arr = []
	#make candidates targets array
	for vx in range(-ran,ran+1): 
		for vy in range(-2,2+1):
			var en = check_unit_pos(unit.map_position+Vector2(vx,vy));
			if !en || en.is_dead: continue
			elif unit.data.team==en.data.team: continue
			else: arr.append(en)
	#chose more close target in array
	var target_unit = null
	var near = 999
	for en in arr:
		var dist = unit.map_position.distance_to(en.map_position)
		if dist<near:
			near = dist
			target_unit = en
	return target_unit

func restore_units_attack():
	for u in $Units.get_children():
		u.have_attack = true

func move_enemies():
	for u in $Units.get_children():
		if !is_instance_valid(u): continue
		if u.is_dead: continue
		if u.data.team!=2: continue
		var just_attack = false
		#ATACAR TORRE
		if u.map_position.x<=1:
			attack_tower(u)
			yield(get_tree().create_timer(.6),"timeout")
			if $Tower.hp<=0:
				yield(get_tree().create_timer(1),"timeout")
				if Global.demo: get_node("../DemoEndPopup").show_popup(false)
				else: get_node("../EndPopup").show_popup(false)
				return
		elif( unit_try_attack(u) ):
			yield(get_tree().create_timer(1.2),"timeout")
		else:
			for i in range(u.data.spd):
				var is_moving = move_to(u,u.map_position+Vector2(-1,0))
				if is_moving: yield(get_tree().create_timer(.4),"timeout")
			yield(get_tree().create_timer(.3),"timeout")
			if unit_try_attack(u): 
				yield(get_tree().create_timer(1.2),"timeout")
	yield(get_tree().create_timer(.3),"timeout")
	move_allies()

func move_allies():
	for u in $Units.get_children():
		if !is_instance_valid(u): continue
		if u.is_dead: continue
		if u.data.team!=1: continue
		if( unit_try_attack(u) ):
			yield(get_tree().create_timer(1.2),"timeout")
	emit_signal("end_all_moves")

func attack_tower(unit):
	var dest = unit.rect_global_position+($Tower.rect_global_position-unit.rect_global_position)/2
	Effects.move_to_yoyo(unit,dest)
	$Tower.damage(unit.data.atk)

func get_units_amount_team(_team):
	var count = 0
	for u in $Units.get_children():
		if u.data.team==_team: count += 1
	return count

func have_any_ally_without_max_heal():
	for u in $Units.get_children(): 
		if u.data.team==1 && u.data.hp<u.data.hpm: return true
	return false

func get_first_cell_x_position():
	return $Grid/c0.rect_global_position.x

func on_unit_clicked(unit):
	emit_signal("unit_clicked",unit)
