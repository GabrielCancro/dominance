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

func to_alpha(node,to=1):
	tween.interpolate_property(node,"modulate:a",node.modulate.a,to,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.start()

func add_mouse_focuser(btn,border_node):
	btn.connect("mouse_entered",self,"on_mouse_focuser",[border_node,true])
	btn.connect("mouse_exited",self,"on_mouse_focuser",[border_node,false])

func on_mouse_focuser(border_node,val):
	border_node.visible = val
