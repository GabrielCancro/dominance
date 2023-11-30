extends Control

var grid_size = Vector2(8,3)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Enemy/EnemyArea.connect("button_down",self,"on_click",[$Enemy])
	print("NAME ",get_grid_node(8,3).name)

func get_grid_node(x,y):
	return $Grid.get_child((x-1)+(y-1)*grid_size.x)

