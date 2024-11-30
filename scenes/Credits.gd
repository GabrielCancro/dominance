extends Control


func _ready():
	Effects.simple_hover_fx($skip)
	$skip.connect("button_down",self,"on_skip")
	$Labels.modulate.a = 0
	var tween = Tween.new()
	add_child(tween)
	yield(get_tree().create_timer(.5),"timeout")
	
	tween.interpolate_property($Labels,"modulate:a",0,1,1.5,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.interpolate_property($Labels,"rect_position:y",-50,0,1.5,Tween.TRANS_QUAD,Tween.EASE_OUT)
	tween.start()
	
	yield(get_tree().create_timer(7),"timeout")
	on_skip()

func on_skip():
	if Global.demo: get_tree().change_scene("res://scenes/DemoMenu.tscn")
	else: get_tree().change_scene("res://scenes/Menu.tscn")
