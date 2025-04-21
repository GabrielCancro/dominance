extends Control


func _ready():
	set_autoloads()
	Effects.initialize_effects()
	get_tree().set_screen_stretch(1,1,Vector2(800,450))
	$skip.connect("button_down",self,"on_skip")
	Saves.load_store_data()
	if Saves.savedData.has("fullscreen"): OS.window_fullscreen = Saves.savedData.fullscreen
	yield(get_tree().create_timer(1),"timeout")
	$VideoPlayer.play()
	yield($VideoPlayer,"finished")
	yield(get_tree().create_timer(.7),"timeout")
	on_skip()

func on_skip():
	if Global.demo: get_tree().change_scene("res://scenes/DemoMenu.tscn")
	else: get_tree().change_scene("res://scenes/Menu.tscn")
#	LevelManager.set_current_level("P1")
	#get_tree().change_scene("res://scenes/Game.tscn")

func set_autoloads():
	var autoloads = [
		"CardData",
		"CardUsage",
		"Effects",
		"Global",
		"Lang",
		"LevelManager",
		"Saves",
		"Sounds",
		"UnitManager",
		"UpgradeData",
	]
	for au in autoloads:
		print("/root/"+au+"  ->  "+"res://autoloads/"+au+".gd")
		get_tree().root.get_node("/root/"+au).set_script(load("res://autoloads/"+au+".gd"))
