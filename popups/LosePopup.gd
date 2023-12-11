extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$btn_menu.connect("button_down",self,"on_back")
	visible = false
	modulate.a = 0
	$Panel.visible = false
	$Panel.modulate.a = 0
	$btn_menu.visible = false
	$btn_menu.modulate.a = 0

func show_popup():
	Global.set_stop_mouse(false)
	Effects.to_alpha(self,1)
	visible = true
	yield(get_tree().create_timer(2),"timeout")
	show_upgrades()
	yield(get_tree().create_timer(3),"timeout")
	Effects.to_alpha($btn_menu,1)
	$btn_menu.visible = true

func show_upgrades():
	Effects.to_alpha($Panel,1)
	$Panel.visible = true

func on_back():
	get_tree().change_scene("res://scenes/Menu.tscn")
