extends Control

var current_selected

func _ready():
	$btn_menu.connect("button_down",self,"on_back")
	$Descriptor.visible = false
	for upg in $Grid.get_children():
		upg.connect("mouse_entered",self,"on_mouse_entered",[upg])
		upg.connect("mouse_exited",self,"on_mouse_exited",[upg])
		upg.connect("button_down",self,"on_button_down",[upg])
		upg.set_data(UpgradeData.UPGRADES.keys()[upg.get_index()])

func on_mouse_entered(upg_node):
	if current_selected: on_mouse_exited(current_selected)
	current_selected = upg_node
	upg_node.select()
	$Descriptor.visible = true
	$Descriptor/Label.text = UpgradeData.get_upg_data(upg_node.code).desc

func on_mouse_exited(upg_node):
	upg_node.unselect()
	if upg_node==current_selected: 
		current_selected = null
		$Descriptor.visible = false

func on_button_down(upg_node):
	print("CLICK ",upg_node.name)

func on_back():
	Sounds.play_sound("button1")
	get_tree().change_scene("res://scenes/Menu.tscn")
