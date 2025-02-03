extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/Button.connect("button_down",self,"on_click_ok")


func show():
	modulate.a = 0
	Effects.appear_from_bottom(self)
	visible = true

func on_click_ok():
	Effects.to_alpha(self,0)
	yield(get_tree().create_timer(.5),"timeout")
	visible = false
