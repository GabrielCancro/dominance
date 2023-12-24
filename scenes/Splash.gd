extends Control


func _ready():
	$skip.connect("button_down",self,"on_skip")
	Saves.load_store_data()
	if Saves.savedData.has("fullscreen"): OS.window_fullscreen = Saves.savedData.fullscreen
	$Label.modulate.a = 0
	$Label2.modulate.a = 0
	var tween = Tween.new()
	add_child(tween)
	yield(get_tree().create_timer(3),"timeout")
	
	tween.interpolate_property($Label,"modulate:a",0,1,1.5,Tween.TRANS_QUAD,Tween.EASE_OUT,.5)
	tween.interpolate_property($Label,"modulate:a",1,0,1,Tween.TRANS_QUAD,Tween.EASE_OUT,2.5)
	tween.interpolate_property($Label2,"modulate:a",0,1,1.5,Tween.TRANS_QUAD,Tween.EASE_OUT,3)
	tween.interpolate_property($Label2,"modulate:a",1,0,1,Tween.TRANS_QUAD,Tween.EASE_OUT,5)
	tween.start()
	
	yield(get_tree().create_timer(7),"timeout")
	get_tree().change_scene("res://scenes/Menu.tscn")

func on_skip():
	get_tree().change_scene("res://scenes/Menu.tscn")
