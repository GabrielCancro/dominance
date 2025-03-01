extends Node2D

var dest_pos
var speed = 600

func _ready():
	pass

func _process(delta):
	global_position += global_position.direction_to(dest_pos)*delta*speed
	look_at(dest_pos)
	if global_position.distance_to(dest_pos)<=delta*speed+1: queue_free()

func set_from_to(nodeA,nodeB):
	if "rect_global_position" in nodeA: global_position = nodeA.rect_global_position
	else: global_position = nodeA.global_position
	if "rect_global_position" in nodeB: dest_pos = nodeB.rect_global_position
	else: dest_pos = nodeB.global_position

