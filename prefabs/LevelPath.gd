extends Node2D
tool

var myId = -1
export var nodeNeedId = -1

func _ready():
	pass # Replace with function body.

func _process(delta):
	var node = get_node_or_null("../P"+str(nodeNeedId))
	var myId = get_index()+1
	if Engine.editor_hint:
		$N/sun.rect_rotation += 4 * PI * delta
		$N/sun.visible = false
		if !node: $Line2D.points[1] = $Line2D.points[0]
		else: $Line2D.points[1] = (node as Node2D).global_position - global_position
		$N/lbl_num.text = str(myId)
	
