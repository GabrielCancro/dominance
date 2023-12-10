extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	localizate()
	$VBox/btn1.connect("button_down",self,"on_click_button",["start"])
	$VBox/btn2.connect("button_down",self,"on_click_button",["lang"])

func localizate():
	print("LOCALIZATE! ",Lang.language)
	$VBox/btn1/Label.text = Lang.get_string("menu_start_game")
	$VBox/btn2/Label.text = Lang.get_string("menu_lang")

func on_click_button(code):
	if code=="start":
		get_tree().change_scene("res://scenes/Game.tscn")
	elif code=="lang":
		if Lang.language=="es": Lang.language = "en"
		elif Lang.language=="en": Lang.language = "es"
		localizate()
