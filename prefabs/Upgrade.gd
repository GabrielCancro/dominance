extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	on_mouse_exited()
	$Area.connect("mouse_entered",self,"on_mouse_entered")
	$Area.connect("mouse_exited",self,"on_mouse_exited")
	$Area.connect("button_down",self,"on_click")


func on_mouse_entered():
	$Upgrade.visible = true
	$ColorRect.visible = true
	
func on_mouse_exited():
	$Upgrade.visible = false
	$ColorRect.visible = false
	
func on_click():
	print("UPGRADE CLICK")
