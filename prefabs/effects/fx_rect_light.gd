extends Control

func _ready(): 
	visible = false

func set_effect(node):
	print("FX SET EFFECT")
	rect_size = node.rect_size
	rect_global_position = node.rect_global_position
	print("rect_size ",rect_size)
	print("rect_global_position ",rect_global_position)
	visible = true

func _process(delta):
	modulate.a -= delta * 2
	rect_scale += Vector2(1,1) * delta * 0.2
	if modulate.a < 0.1: queue_free()
