extends Node

onready var tween = Tween.new()

func _ready():
	add_child(tween)

func move_to(node,dest):
	tween.interpolate_property(node,"rect_global_position",node.rect_global_position,dest,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.start()

func move_to_yoyo(node,dest):
	var start_pos = node.rect_global_position
	tween.interpolate_property(node,"rect_global_position",node.rect_global_position,dest,.2,Tween.TRANS_QUAD,Tween.EASE_IN)
	tween.interpolate_property(node,"rect_global_position",dest,start_pos,.2,Tween.TRANS_QUAD,Tween.EASE_OUT,.25)
	tween.start()

func disappear(node,to=Vector2(0,0)):
	if !node: return
	if !is_instance_valid(node): return
	var dest = node.rect_global_position + to
	tween.interpolate_property(node,"rect_global_position",node.rect_global_position,dest,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.interpolate_property(node,"modulate:a",node.modulate.a,0,.3,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.start()
	yield(tween,"tween_completed")
	if !node: return
	if !is_instance_valid(node): return
	node.queue_free()

func to_alpha(node,to=1):
	tween.interpolate_property(node,"modulate:a",node.modulate.a,to,.2,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.start()

func to_alpha_slow(node,to=1):
	tween.interpolate_property(node,"modulate:a",node.modulate.a,to,1,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.start()
	
func to_scale(node,to=1):
	tween.interpolate_property(node,"rect_scale",node.rect_scale,Vector2(to,to),.2,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()

func add_mouse_focuser(btn,border_node):
	border_node.visible = false
	btn.connect("mouse_entered",self,"on_mouse_focuser",[border_node,true])
	btn.connect("mouse_exited",self,"on_mouse_focuser",[border_node,false])

func on_mouse_focuser(border_node,val):
	border_node.visible = val

func shake(node,power=2,time=.5):
	var ini_pos = node.rect_position
	randomize()
	while time>0:
		if !is_instance_valid(node): return
		node.rect_position = ini_pos + Vector2(rand_range(-power,power),rand_range(-power/2,power/2))
		time -= .025
		yield(get_tree().create_timer(.025),"timeout")
	node.rect_position = ini_pos

func colorization(node,color):
	var start_color = node.modulate
	tween.interpolate_property(node,"modulate",color,start_color,.4,Tween.TRANS_QUAD,Tween.EASE_IN)
	tween.start()

func shine(node):
	var start_color = node.modulate
	var shine_color = Color(5,5,5,5)
	tween.interpolate_property(node,"modulate",start_color,shine_color,.2,Tween.TRANS_QUAD,Tween.EASE_IN)
	tween.interpolate_property(node,"modulate",shine_color,start_color,.2,Tween.TRANS_QUAD,Tween.EASE_OUT,.3)
	tween.start()

func scaled_from(node):
	var start_scale = node.rect_scale
	tween.interpolate_property(node,"rect_scale",node.rect_scale*1.2,start_scale,.4,Tween.TRANS_QUAD,Tween.EASE_IN)
	tween.start()

func spark_light(pos):
	var node = preload("res://prefabs/effects/fx_shine_light.tscn").instance()
	get_node("/root").add_child(node)
	node.rect_position = pos

func rectangle_shine_fx(node):
	var fx = preload("res://prefabs/effects/fx_rect_light.tscn").instance()
	get_node("/root").add_child(fx)
	fx.set_effect(node)

func fx_add_enemy(node):
	node.modulate.a = 0
	yield(get_tree().create_timer(.1),"timeout")
	var start_pos = node.rect_global_position + Vector2(50,0)
	var end_pos = node.rect_global_position
	tween.interpolate_property(node,"rect_global_position",start_pos,end_pos,.5,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.interpolate_property(node,"modulate:a",0,1,.5,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.start()
	
func appear_from_bottom(node):
	var start_pos = node.rect_global_position + Vector2(0,+20)
	var end_pos = node.rect_global_position
	tween.interpolate_property(node,"rect_global_position",start_pos,end_pos,1,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.interpolate_property(node,"modulate:a",0,1,1,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.start()

func simple_hover_fx(node):
	node.connect("mouse_entered",self,"simple_hover_func",[node,true])
	node.connect("mouse_exited",self,"simple_hover_func",[node,false])

func simple_hover_func(node,val):
	if val: tween.interpolate_property(node,"rect_scale",null,Vector2(1.1,1.1),.2,Tween.TRANS_QUAD,Tween.EASE_OUT)
	else: tween.interpolate_property(node,"rect_scale",null,Vector2(1,1),.2,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.start()

signal add_sunpoints_effect_end
func add_sunpoints(amount,pos):
	for i in range(amount):
		var n = preload("res://prefabs/effects/fx_sunpoint_getted.tscn").instance()
		n.delay = i*0.1
		get_node("/root").add_child(n)
		n.rect_global_position = pos# - Vector2(25,25)
		
