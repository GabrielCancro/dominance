extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	localizate()
	$VBox/btn1.connect("button_down",self,"on_click_button",["start"])
	$VBox/btn2.connect("button_down",self,"on_click_button",["options"])
	#$VBox/btn3.connect("button_down",self,"on_click_button",["fullscreen"])
	$VBox/btn4.connect("button_down",self,"on_click_button",["quit"])
	$Upg/upgrades.connect("button_down",self,"on_upgrades_click")
	update_upgrades_button()

func localizate():
	$VBox/btn1/Label.text = Lang.get_string("menu_start_game")
	$VBox/btn2/Label.text = Lang.get_string("menu_options")
	#$VBox/btn3/Label.text = Lang.get_string("menu_fullscreen")
	$VBox/btn4/Label.text = Lang.get_string("menu_quit")
	$btn_clear/Label.text = Lang.get_string("title_clear_data")
	$PathBattles.update_level()

func on_click_button(code):
	Sounds.play_sound("button1")
	if code=="start":
		get_tree().change_scene("res://scenes/Game.tscn")
	elif code=="options":
		get_tree().change_scene("res://scenes/Options.tscn")
	elif code=="quit":
		$Transition.fade()
		yield(get_tree().create_timer(.5),"timeout")
		get_tree().quit()

func on_upgrades_click():
	print("CLICK UPGRADES")
	Sounds.play_sound("button1")
	get_tree().change_scene("res://scenes/Upgrade.tscn")

func update_upgrades_button():
	#$Upg.visible = (Saves.savedData.level>1 || Saves.savedData.days>0) 
	$Upg/Label.text = str(Saves.savedData.days)
