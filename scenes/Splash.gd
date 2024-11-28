extends Control


func _ready():
	preload("res://assets/movies/pk_logo.ogv")
	$skip.connect("button_down",self,"on_skip")
	Saves.load_store_data()
	if Saves.savedData.has("fullscreen"): OS.window_fullscreen = Saves.savedData.fullscreen
	yield(get_tree().create_timer(.5),"timeout")
	$VideoPlayer.play()
	yield(get_tree().create_timer(7),"timeout")
	on_skip()

func on_skip():
	if Global.demo: get_tree().change_scene("res://scenes/DemoMenu.tscn")
	else: get_tree().change_scene("res://scenes/Menu.tscn")
