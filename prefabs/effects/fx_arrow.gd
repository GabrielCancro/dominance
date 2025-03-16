extends Node2D

var start_pos
var dest_pos
var top = 50
var progress = 0
var time = .5

func _ready():
	pass

func _process(delta):
	progress += delta/time
	global_position.x = start_pos.x + (dest_pos.x - start_pos.x) * progress
	var offsety = top * pow(progress*2-1,2)
	#look_at(global_position+Vector2((dest_pos.x - start_pos.x)/time,(top-offsety)/time))
	rotation_degrees = (progress*2-1)*top
	global_position.y = start_pos.y + (dest_pos.y - start_pos.y) * progress -top + offsety 
	if abs(dest_pos.x-global_position.x)<=10: 
		set_process(false)
		Effects.to_alpha(self,0)
		yield(get_tree().create_timer(.5),"timeout")
		queue_free()

func set_from_to(nodeA,nodeB):
	if "rect_global_position" in nodeA: global_position = nodeA.rect_global_position + Vector2(nodeA.rect_size.x/2,0)
	else: global_position = nodeA.global_position
	if "rect_global_position" in nodeB: dest_pos = nodeB.rect_global_position + nodeB.rect_size/2
	else: dest_pos = nodeB.global_position
	start_pos = global_position
#	top = (dest_pos.x-start_pos.x)*0.2

