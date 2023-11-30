extends Node

onready var tween = Tween.new()
onready var scene = get_node("/root/Game")

# Called when the node enters the scene tree for the first time.
func _ready():
	scene.add_child(tween)

func move_to(node,dest):
	tween.interpolate_property(node,"rect_global_position",node.rect_global_position,dest,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.start()

func disappear(node,to=Vector2(0,0)):
	var dest = node.rect_global_position + to
	tween.interpolate_property(node,"rect_global_position",node.rect_global_position,dest,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.interpolate_property(node,"modulate:a",node.modulate.a,0,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.start()
	yield(tween,"tween_completed")
	node.queue_free()


