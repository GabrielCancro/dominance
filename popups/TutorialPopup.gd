extends Control

var gameStarted = false

func _ready():
	$btn_menu.connect("button_down",self,"on_click")
	visible = true
	
	$Panel/Label1.text = Lang.get_string("tutorial_1")
	$Panel/Label2.text = Lang.get_string("tutorial_2")
	$Panel/Label3.text = Lang.get_string("tutorial_3")
	$btn_menu/Label.text = Lang.get_string("start")

func on_click():
	Sounds.play_sound("button1")
	if !gameStarted: get_node("/root/Game").start_game()
	gameStarted = true
	visible = false
