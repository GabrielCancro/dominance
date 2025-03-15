extends Control

var days = 0

func _ready():
	Effects.simple_hover_fx($btn_continue)
	Effects.simple_hover_fx($btn_quit)
	$btn_continue.connect("button_down",self,"on_back")
	$btn_quit.connect("button_down",self,"on_quit")
	visible = false

func show_popup():
	Global.set_stop_mouse(false)
	$lb_title.text = Lang.get_string( "exit_battle_title" )
	$lb_desc.text = Lang.get_string( "exit_battle_text" )
	$btn_continue/Label.text = Lang.get_string( "exit_battle_continue" )
	$btn_quit/Label.text = Lang.get_string( "exit_battle_quit" )
	Effects.to_alpha(self,1)
	visible = true

func on_back():
	Sounds.play_sound("button1")
	visible = false

func on_quit():
	Sounds.play_sound("button1")
	if Global.demo: get_tree().change_scene("res://scenes/DemoMenu.tscn")
	else: get_tree().change_scene("res://scenes/SelectLevel.tscn")
