extends Control

signal close_popup
var ttl = 0.0

func _ready():
	$Panels/all/Label1.text = Lang.get_string("tutorial_1")
	$Panels/all/Label2.text = Lang.get_string("tutorial_2")
	$Panels/all/Label3.text = Lang.get_string("tutorial_3")
	visible = false
	for ch in $Panels.get_children(): ch.get_node("btn").connect("button_down",self,"on_click")

func _process(delta):
	ttl += delta*3
	$Panels/burn/arrow.rect_position.x += sin(ttl)*0.25

func show_tuto(code):
	self.modulate.a = 0
	for ch in $Panels.get_children(): ch.visible = false
	$Panels.get_node(code).visible = true
	visible = true
	Effects.appear_from_bottom(self)

func on_click():
	Sounds.play_sound("button1")
	hide_tuto()

func hide_tuto():
	Effects.to_alpha(self,0)
	yield(get_tree().create_timer(.5),"timeout")
	visible = false
	emit_signal("close_popup")
