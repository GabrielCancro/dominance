extends Control

func _ready():
	$btn_menu.connect("button_down",self,"on_back")
	visible = false
	$btn_menu.visible = false

func show_popup(win=false):
	Global.set_stop_mouse(false)
	var days = get_node("/root/Game/DayCounter").day
	if !win: days = floor(days*.5)
	$lbl_days.text = str(days)
	if win: 
		Sounds.play_sound("win1")
		Saves.savedData.level += 1
	Saves.savedData.days += days
	Saves.save_store_data()
	if win: $Label.text = Lang.get_string( "win_game" )
	else: $Label.text = Lang.get_string( "lose_game" )
	$lbl_win.text = Lang.get_string( "win_text" )
	$lbl_win.visible = win
	modulate.a = 0
	Effects.to_alpha(self,1)
	visible = true
	yield(get_tree().create_timer(1),"timeout")
	show_end_button()

func show_end_button():
	$btn_menu/Label.text = Lang.get_string( "back_to_main" )
	$btn_menu.modulate.a = 0
	Effects.to_alpha($btn_menu,1)
	$btn_menu.visible = true

func on_back():
	Sounds.play_sound("button1")
	get_tree().change_scene("res://scenes/Menu.tscn")
