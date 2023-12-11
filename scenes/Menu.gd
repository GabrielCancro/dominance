extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Saves.load_store_data()
	localizate()
	$VBox/btn1.connect("button_down",self,"on_click_button",["start"])
	$VBox/btn2.connect("button_down",self,"on_click_button",["lang"])
	$btn_clear.connect("button_down",Saves,"clear_data")

func localizate():
	$VBox/btn1/Label.text = Lang.get_string("menu_start_game")
	$VBox/btn2/Label.text = Lang.get_string("menu_lang")
	update_upgrades()

func on_click_button(code):
	if code=="start":
		get_tree().change_scene("res://scenes/Game.tscn")
	elif code=="lang":
		if Saves.savedData.language=="es": Saves.savedData.language = "en"
		elif Saves.savedData.language=="en": Saves.savedData.language = "es"
		Saves.save_store_data()
		localizate()

func update_upgrades():
	for i in range(6):
		var code = "upg"+str(i+1)
		var node = get_node(code)
		node.visible = (Saves.savedData.upgrades.find(code) != -1)
		node.set_data(code)
