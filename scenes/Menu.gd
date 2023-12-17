extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Saves.load_store_data()
	localizate()
	$VBox/btn1.connect("button_down",self,"on_click_button",["start"])
	$VBox/btn2.connect("button_down",self,"on_click_button",["lang"])
	$btn_clear.connect("button_down",Saves,"clear_data")
	$Upg/upgrades.connect("button_down",self,"on_upgrades_click")
	$LabelInvasion.text = "invasion "+str(Saves.savedData.level)
	$LabelInvasion.visible = (Saves.savedData.level>1)
	update_upgrades_button()

func localizate():
	$VBox/btn1/Label.text = Lang.get_string("menu_start_game")
	$VBox/btn2/Label.text = Lang.get_string("menu_lang")

func on_click_button(code):
	Sounds.play_sound("button1")
	if code=="start":
		get_tree().change_scene("res://scenes/Game.tscn")
	elif code=="lang":
		if Saves.savedData.language=="es": Saves.savedData.language = "en"
		elif Saves.savedData.language=="en": Saves.savedData.language = "es"
		Saves.save_store_data()
		localizate()

func on_upgrades_click():
	print("CLICK UPGRADES")
	Sounds.play_sound("button1")
	get_tree().change_scene("res://scenes/Upgrade.tscn")

func update_upgrades_button():
	$Upg.visible = (Saves.savedData.level>1 || Saves.savedData.days>0) 
	$Upg/Label.text = str(Saves.savedData.days)
