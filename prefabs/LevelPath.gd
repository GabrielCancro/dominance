extends Node2D
tool

enum TypeEnum {LEVEL, SUN, CHEST}
enum StateEnum {DISABLE, ENABLE, COMPLETE}
export(TypeEnum) var type
export(StateEnum) var state

var close_nodes

func _ready():
	$Button.connect("button_down",self,"on_click")
	set_type()
	set_close_nodes()
	connect_close_nodes()

func _process(delta):
	$N/sun.rect_rotation += 4 * PI * delta
	if Engine.editor_hint:
		set_type()
		set_close_nodes()
		connect_close_nodes()

func set_type():
	$N/lbl_num.text = str(get_index()+1)
	$N/sun.visible = false
	$N/level.visible = false
	$N/chest.visible = false
	if type == TypeEnum.LEVEL: $N/level.visible = true
	if type == TypeEnum.SUN: 
		$N/sun.visible = true
		if state == StateEnum.DISABLE:
			$N/sun.rect_rotation = 0
			$N/sun.modulate = Color(.3,.3,.7,1)
	if type == TypeEnum.CHEST: $N/chest.visible = true

func set_close_nodes():
	close_nodes = []
	for lp in get_parent().get_children():
		var dist = position.distance_to(lp.position)
		if dist>20 && dist<100: close_nodes.append(lp)

func connect_close_nodes():
	for ln in $L.get_children():
		var i = ln.get_index()
		if i < close_nodes.size():
			ln.points[1] = close_nodes[i].global_position - global_position
		else: ln.points[1] = Vector2(0,9)

func on_click():
	var arr = []
	for c in close_nodes: arr.append(c.name)
	print("CLOSE NODES: ",arr)
