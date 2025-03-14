extends Node2D
tool

enum TypeEnum {LEVEL, SUN, CHEST}
enum StateEnum {DISABLE, ENABLE, COMPLETE}
export(TypeEnum) var type
export(StateEnum) var state

var close_nodes
var link_dist = 80

signal on_hint(val)

func _ready():
	$Button.connect("button_down",self,"on_click")
	$Button.connect("mouse_entered",self,"on_hint",[true])
	$Button.connect("mouse_exited",self,"on_hint",[false])
	set_type()
	set_close_nodes()
	connect_close_nodes()

func _process(delta):
	if type == TypeEnum.SUN && state == StateEnum.ENABLE: $N/SUN_ENABLE.rect_rotation += 4 * PI * delta
	if Engine.editor_hint:
		set_type()
		set_close_nodes()
		connect_close_nodes()

func set_type():
	for n in $N.get_children(): n.visible = false
	var node = $N.get_node_or_null(["LEVEL","SUN","CHEST"][type]+"_"+["DISABLE","ENABLE","COMPLETE"][state])
	if node: node.visible = true

func set_close_nodes():
	close_nodes = []
	for lp in get_parent().get_children():
		var dist = position.distance_to(lp.position)
		if dist>20 && dist<link_dist: close_nodes.append(lp)

func connect_close_nodes():
	for ln in $L.get_children():
		if ln==self: continue
		var i = ln.get_index()
		if i < close_nodes.size():
			ln.points[1] = close_nodes[i].global_position - global_position
		else: ln.points[1] = Vector2(0,9)

func on_click():
	if type == TypeEnum.LEVEL && state == StateEnum.COMPLETE:
		LevelManager.set_current_level(name)
		get_tree().change_scene("res://scenes/SelectBuild.tscn")
	if state != StateEnum.ENABLE: return
	if type!=TypeEnum.LEVEL: state = StateEnum.COMPLETE
	get_node("../../").levelpath_click(self)
	set_type()
	if type==TypeEnum.LEVEL: 
		LevelManager.set_current_level(name)
		Effects.appear_from_bottom($N/LEVEL_COMPLETE/tower)
		yield(get_tree().create_timer(.5),"timeout")
		get_tree().change_scene("res://scenes/SelectBuild.tscn")
	if type==TypeEnum.SUN: 
		Effects.add_sunpoints(15,global_position)
	if type==TypeEnum.CHEST: 
		get_node("../../UI/UpgradeGetted").show()
		yield(get_node("../../UI/UpgradeGetted"),"on_close")
		get_node("../../UI/UpgradeGetted").show()
	update_connected_states()

func update_connected_states():
	if state!=StateEnum.COMPLETE: return
	for c in close_nodes:
		if c.state==StateEnum.DISABLE:
			c.state=StateEnum.ENABLE
			c.set_type()

func on_hint(val):
	emit_signal("on_hint",val)
