extends Control

var current_selected

func _ready():
	$btn_menu.connect("button_down",self,"on_back")
	$Descriptor.visible = false
	$lbl_title.text = Lang.get_string("upgrades")
	$lbl_points.text = Lang.get_string("points")+": "+str(Saves.savedData.points)
	$btn_menu/Label.text = Lang.get_string("back_to_main")
	
	for upg in $Grid.get_children():
		upg.connect("mouse_entered",self,"on_mouse_entered",[upg])
		upg.connect("mouse_exited",self,"on_mouse_exited",[upg])
		upg.connect("button_down",self,"on_button_down",[upg])
		var code = UpgradeData.UPGRADES.keys()[upg.get_index()]
		upg.set_data(code)
		if(Saves.savedData.upgrades.find(code)!=-1): upg.blu_shine()
		if(upg.get_index()>=2+Saves.savedData.upgrades.size()*2): upg.modulate.a = .3

func on_mouse_entered(upg_node):
	if(upg_node.modulate.a<1): return
	if current_selected: on_mouse_exited(current_selected)
	current_selected = upg_node
	upg_node.select()
	$Descriptor.visible = true
	$Descriptor/Label.text = UpgradeData.get_upg_data(upg_node.code).desc

func on_mouse_exited(upg_node):
	if(upg_node.modulate.a<1): return
	upg_node.unselect()
	if upg_node==current_selected: 
		current_selected = null
		$Descriptor.visible = false

func on_button_down(upg_node):
	if(Saves.savedData.upgrades.find(upg_node.code)!=-1): return
	if(Saves.savedData.points<=0): return
	if(upg_node.modulate.a<1): return
	Saves.savedData.points -= 1
	UpgradeData.add_upgrade(upg_node.code)
	get_tree().change_scene("res://scenes/Upgrade.tscn")
	Saves.save_store_data()
	Sounds.play_sound("button1")
	print(Saves.savedData.upgrades)

func on_back():
	Sounds.play_sound("button1")
	get_tree().change_scene("res://scenes/Menu.tscn")
