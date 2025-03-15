extends Control

func _ready():
	Effects.simple_hover_fx($btn_menu)
	$btn_menu.connect("button_down",self,"on_back")
	visible = false
	$btn_menu.visible = false

func show_popup(win=false):
	Global.set_stop_mouse(false)
	if win:
		Sounds.play_sound("win1")
		Saves.savedData["levelPath"][LevelManager.current_level_data.name] = 2 #COMPLETED
		Saves.save_store_data()
		$lb_title.text = Lang.get_string( "win_game" )
		$lb_text.text = Lang.get_string( "end_battle_win_text" )
	else: 
		$lb_title.text = Lang.get_string( "lose_game" )
		$lb_text.text = Lang.get_string( "end_battle_lose_text" )
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
	get_tree().change_scene("res://scenes/SelectLevel.tscn")
