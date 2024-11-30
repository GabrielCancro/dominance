extends Control

var current_selected

func _ready():
	randomize()
	Effects.simple_hover_fx($btn_yes)
	Effects.simple_hover_fx($btn_no)
	$btn_yes.connect("button_down",self,"on_yes")
	$btn_no.connect("button_down",self,"on_no")
	$lbl_title.text = Lang.get_string("title_clear_data")
	$Label.text = Lang.get_string("warning_clear_data")
	$btn_yes/Label.text = Lang.get_string("btn_yes")
	$btn_no/Label.text = Lang.get_string("btn_no")

func on_yes():
	Sounds.play_sound("button1")
	Saves.clear_data()

func on_no():
	Sounds.play_sound("button1")
	get_tree().change_scene("res://scenes/Options.tscn")
