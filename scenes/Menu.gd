extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	localizate()
	$VBox/btn1.connect("button_down",self,"on_click_button",["start"])
	$VBox/btn2.connect("button_down",self,"on_click_button",["lang"])
	$VBox/btn3.connect("button_down",self,"on_click_button",["fullscreen"])
	$VBox/btn4.connect("button_down",self,"on_click_button",["quit"])
	$btn_clear.connect("button_down",self,"on_click_button",["clear_data"])
	$Upg/upgrades.connect("button_down",self,"on_upgrades_click")
	$LabelInvasion.visible = (Saves.savedData.level>1)
	update_upgrades_button()

func localizate():
	$VBox/btn1/Label.text = Lang.get_string("menu_start_game")
	$VBox/btn2/Label.text = Lang.get_string("menu_lang")
	$VBox/btn3/Label.text = Lang.get_string("menu_fullscreen")
	$VBox/btn4/Label.text = Lang.get_string("menu_quit")
	$btn_clear/Label.text = Lang.get_string("title_clear_data")
	$LabelInvasion.text = "invasion: "+str(Saves.savedData.level)
	if Saves.savedData.level==5: $LabelInvasion.text = Lang.get_string("end_battle")
	if Saves.savedData.level>5: $LabelInvasion.text = Lang.get_string("endless_mode")+": "+str(Saves.savedData.level-5)

func on_click_button(code):
	Sounds.play_sound("button1")
	if code=="start":
		get_tree().change_scene("res://scenes/Game.tscn")
	elif code=="lang":
		if Saves.savedData.language=="es": Saves.savedData.language = "en"
		elif Saves.savedData.language=="en": Saves.savedData.language = "es"
		Saves.save_store_data()
		localizate()
	elif code=="fullscreen":
		OS.window_fullscreen = !OS.window_fullscreen
		Saves.savedData.fullscreen = OS.window_fullscreen
		Saves.save_store_data()
	elif code=="quit":
		$Transition.fade()
		yield(get_tree().create_timer(.5),"timeout")
		get_tree().quit()
	elif code=="clear_data":
		get_tree().change_scene("res://scenes/ClearData.tscn")

func on_upgrades_click():
	print("CLICK UPGRADES")
	Sounds.play_sound("button1")
	get_tree().change_scene("res://scenes/Upgrade.tscn")

func update_upgrades_button():
	$Upg.visible = (Saves.savedData.level>1 || Saves.savedData.days>0) 
	$Upg/Label.text = str(Saves.savedData.days)
