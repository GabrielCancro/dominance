extends Control

func _ready():
	#$Button.connect("mouse_entered",self,"on_enter_mouse")
	#$Button.connect("mouse_exited",self,"on_exit_mouse")
	on_exit_mouse()

func on_enter_mouse():
	$LabelInvasion.visible = true

func on_exit_mouse():
	$LabelInvasion.visible = false
