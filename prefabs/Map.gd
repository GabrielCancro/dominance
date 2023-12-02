extends Control

var grid_size = Vector2(8,3)

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(.5),"timeout")
	add_unit("slime",8,1)
	add_unit("slime",7,2)
	add_unit("slime",8,3)
	$btn1.connect("button_down",self,"create_unit_left")

func get_grid_node(pos):
	var grid_node = $Grid.get_child((pos.x-1)+(pos.y-1)*grid_size.x)
	return grid_node

func add_unit(type,x,y):
	var unit = UnitManager.create_new_unit(type)
	$Units.add_child(unit)
	unit.map_position = Vector2(x,y)
	unit.rect_global_position = get_grid_node(unit.map_position).rect_global_position
	unit.get_node("EnemyArea").connect("button_down",self,"unit_walk",[unit])
	return unit

func move_to(unit,pos):
	if pos.x<1: pos.x = 1
	if pos.y<1: pos.y = 1
	if pos.x>8: pos.x = 8
	if pos.y>3: pos.y = 3
	unit.map_position = pos
	var des = get_grid_node(unit.map_position).rect_global_position
	Effects.move_to(unit,des)

func unit_walk(unit):
	if unit.map_position.x<=1: 
		UnitManager.attack_tower(unit)
	else:
		move_to(unit,unit.map_position+Vector2(-1,0))

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

func create_unit_left():
	var u = add_unit("soldier",1,1);
	unit_push(u);
