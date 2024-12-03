extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Effects.simple_hover_fx($VBox/btn2)
	Effects.simple_hover_fx($VBox/btn3)
	Effects.simple_hover_fx($VBox/btn4)
	Effects.simple_hover_fx($VBox/btn6)
	Effects.simple_hover_fx($HSlider)
	$VBox/btn2.connect("button_down",self,"on_click_button",["lang"])
	$VBox/btn3.connect("button_down",self,"on_click_button",["fullscreen"])
	$VBox/btn4.connect("button_down",self,"on_click_button",["clear"])
	$VBox/btn6.connect("button_down",self,"on_click_button",["back"])
	$HSlider.connect("value_changed",self,"on_change_scroll")
	$HSlider.connect("drag_ended",self,"on_change_scroll_end")
	$HSlider.value = Saves.savedData.mvol
	on_change_scroll($HSlider.value)
	localizate()

func localizate():
	#$VBox/btn1/Label.text = Lang.get_string("menu_start_game")
	$lbl_title.text = Lang.get_string("menu_options")
	$VBox/btn2/Label.text = Lang.get_string("menu_lang")
	$VBox/btn3/Label.text = Lang.get_string("menu_fullscreen")
	$VBox/btn4/Label.text = Lang.get_string("title_clear_data")
	$VBox/btn6/Label.text = Lang.get_string("back_to_main")

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
	elif code=="back":
		get_tree().change_scene("res://scenes/Menu.tscn")
	elif code=="clear":
		get_tree().change_scene("res://scenes/ClearData.tscn")

func on_change_scroll(val):
	$HLabel.text = "vol "+str(val)+"%"

func on_change_scroll_end(val):
	print("END CHANGE ",val)
	Sounds.set_vol($HSlider.value)
	Sounds.play_sound("fail1")
	Saves.savedData.mvol = $HSlider.value
	Saves.save_store_data()
