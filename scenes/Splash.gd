extends Control

var sfx
var skipped = false

func _ready():
	set_autoloads()
	Effects.initialize_effects()
	get_tree().set_screen_stretch(1,1,Vector2(800,450))
	$skip.connect("button_down",self,"on_skip")
	Saves.load_store_data()
	if !Global.mobile && Saves.savedData.has("fullscreen"): OS.window_fullscreen = Saves.savedData.fullscreen
	play_anim()

func on_skip():
	skipped = true
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

func play_anim():
	var cpos = get_viewport_rect().size/2
	$Pump.position = cpos
	$Pump.position.y -= 40
	$Logo.rect_position.y -= 40
	$Pump.modulate.a = 0
	$Logo.modulate.a = 0
	$Pump.play("idle")
	
	$Tween.interpolate_property($Pump,"modulate:a",0,1,0.2,Tween.TRANS_QUAD,Tween.EASE_IN,1)
	$Tween.start()
	yield(get_tree().create_timer(1),"timeout")
	if skipped: return
	sfx = Sounds.play_sound("intro_splash")
	yield(get_tree().create_timer(1),"timeout")
	if skipped: return
	
	$Pump.play("eye")
	$Tween.interpolate_property($Logo,"modulate:a",0,1,0.5,Tween.TRANS_QUAD,Tween.EASE_OUT,.2)
	$Tween.interpolate_property($Pump,"position:x",null,cpos.x-160,0.2,Tween.TRANS_QUAD,Tween.EASE_OUT,.2)
	$Tween.interpolate_property($Logo,"rect_position:x",null,cpos.x-70,0.2,Tween.TRANS_LINEAR,Tween.EASE_IN,.2)
	$Tween.start()
	yield(get_tree().create_timer(1),"timeout")
	if skipped: return
	$Pump.play("idle")
	yield(get_tree().create_timer(1),"timeout")
	if skipped: return
	$Tween.interpolate_property($Pump,"modulate:a",1,0,0.5,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.interpolate_property($Logo,"modulate:a",1,0,0.5,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.interpolate_property($TextureRect,"modulate:a",1,0,0.3,Tween.TRANS_QUAD,Tween.EASE_OUT,.2)
	$Tween.start()
	yield(get_tree().create_timer(1),"timeout")
	if skipped: return
	on_skip()
