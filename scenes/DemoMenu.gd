extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	localizate()
	$VBox/btn1.connect("button_down",self,"on_click_button",["start"])
	$VBox/btn2.connect("button_down",self,"on_click_button",["lang"])
	$VBox/btn3.connect("button_down",self,"on_click_button",["quit"])
	first_play_effects()

func first_play_effects():
	$Title.modulate.a = 0
	$Label.modulate.a = 0
	$VBox.modulate.a = 0
	$VBox.visible = false
	yield(get_tree().create_timer(.5),"timeout")
	Effects.appear_from_bottom($Title)
	yield(get_tree().create_timer(.3),"timeout")
	Effects.appear_from_bottom($Label)
	yield(get_tree().create_timer(.7),"timeout")
	$VBox.visible = true
	Effects.appear_from_bottom($VBox)

func localizate():
	$VBox/btn1/Label.text = Lang.get_string("menu_start_game")
	$VBox/btn2/Label.text = Lang.get_string("menu_lang")
	$VBox/btn3/Label.text = Lang.get_string("menu_quit")

func on_click_button(code):
	Sounds.play_sound("button1")
	if code=="start":
		Saves.default_data.level = 1
		get_tree().change_scene("res://scenes/Game.tscn")
	elif code=="lang":
		if Saves.savedData.language=="es": Saves.savedData.language = "en"
		elif Saves.savedData.language=="en": Saves.savedData.language = "es"
		Saves.save_store_data()
		localizate()
	elif code=="quit":
		$Transition.fade()
		yield(get_tree().create_timer(.5),"timeout")
		get_tree().quit()

func on_upgrades_click():
	print("CLICK UPGRADES")
	Sounds.play_sound("button1")
	get_tree().change_scene("res://scenes/Upgrade.tscn")

func on_invasion_click():
	$InvasionUIButton.disabled = true
	Effects.scaled_from($VBox/btn1)
	Sounds.play_sound("tum1")
	yield(get_tree().create_timer(.5),"timeout")
	$InvasionUIButton.disabled = false
