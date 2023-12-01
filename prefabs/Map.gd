extends Control

var grid_size = Vector2(8,3)

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(.5),"timeout")
	add_unit(8,1)
	add_unit(7,2)
	add_unit(8,3)

func get_grid_node(pos):
	var grid_node = $Grid.get_child((pos.x-1)+(pos.y-1)*grid_size.x)
	return grid_node

func add_unit(x,y):
	var unit = UnitManager.create_new_unit("slime")
	$Units.add_child(unit)
	unit.map_position = Vector2(x,y)
	unit.rect_global_position = get_grid_node(unit.map_position).rect_global_position
	unit.get_node("EnemyArea").connect("button_down",self,"unit_walk",[unit])

func unit_walk(unit):
	if unit.map_position.x<=1: 
		UnitManager.attack_tower(unit)
	else:
		unit.map_position.x -= 1
		var des = get_grid_node(unit.map_position).rect_global_position
		Effects.move_to(unit,des)
