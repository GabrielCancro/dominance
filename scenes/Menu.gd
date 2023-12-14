extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Saves.load_store_data()
	localizate()
	$VBox/btn1.connect("button_down",self,"on_click_button",["start"])
	$VBox/btn2.connect("button_down",self,"on_click_button",["lang"])
	$btn_clear.connect("button_down",Saves,"clear_data")
	$Upg/upgrades.connect("button_down",self,"on_upgrades_click")
	update_upgrades_button()

func localizate():
	$VBox/btn1/Label.text = Lang.get_string("menu_start_game")
	$VBox/btn2/Label.text = Lang.get_string("menu_lang")

func on_click_button(code):
	if code=="start":
		get_tree().change_scene("res://scenes/Game.tscn")
	elif code=="lang":
		if Saves.savedData.language=="es": Saves.savedData.language = "en"
		elif Saves.savedData.language=="en": Saves.savedData.language = "es"
		Saves.save_store_data()
		localizate()

func on_upgrades_click():
	print("CLICK UPGRADES")
	get_tree().change_scene("res://scenes/Upgrade.tscn")

func update_upgrades_button():
	if Saves.savedData.points>0: $Upg.color.a = 1
	else: $Upg.color.a = 0
	$Upg/Label.text = str(Saves.savedData.days)
