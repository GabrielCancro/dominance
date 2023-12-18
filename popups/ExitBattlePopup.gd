extends Control

var days = 0

func _ready():
	$btn_continue.connect("button_down",self,"on_back")
	$btn_quit.connect("button_down",self,"on_quit")
	visible = false

func show_popup():
	Global.set_stop_mouse(false)
	days = get_node("/root/Game/DayCounter").day
	days = max(0,days-5)
	days = floor(days*0.5)
	$lbl_days.text = str(days)
	
	$Label.text = Lang.get_string( "exit_battle_title" )
	$Label2.text = Lang.get_string( "exit_battle_text" )
	$btn_continue/Label.text = Lang.get_string( "exit_battle_continue" )
	$btn_quit/Label.text = Lang.get_string( "exit_battle_quit" )

	Effects.to_alpha(self,1)
	visible = true

func on_back():
	Sounds.play_sound("button1")
	visible = false

func on_quit():
	Saves.savedData.days += days
	Saves.save_store_data()
	Sounds.play_sound("button1")
	get_tree().change_scene("res://scenes/Menu.tscn")
