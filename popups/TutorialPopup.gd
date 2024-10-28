extends Control

func _ready():
	$btn_menu.connect("button_down",self,"on_click")	
	$Panel_all/Label1.text = Lang.get_string("tutorial_1")
	$Panel_all/Label2.text = Lang.get_string("tutorial_2")
	$Panel_all/Label3.text = Lang.get_string("tutorial_3")
	$btn_menu/Label.text = Lang.get_string("ok")

func show_tuto(code):
	self.modulate.a = 0
	$Panel_all.visible = false
	$Panel_burn.visible = false
	get_node("Panel_"+code).visible = true
	visible = true
	Effects.appear_from_bottom(self)

func on_click():
	Sounds.play_sound("button1")
	visible = false
