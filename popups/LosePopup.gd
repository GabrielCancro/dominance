extends Control

var upgrade_selected
var min_days_to_upgrade = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	$btn_menu.connect("button_down",self,"on_back")
	visible = false
	$btn_menu.visible = false

func show_popup():
	Global.set_stop_mouse(false)
	$Label.text = Lang.get_string( "lose_game" )
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
