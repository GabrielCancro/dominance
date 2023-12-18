extends Control

var current_selected

func _ready():
	$btn_menu.connect("button_down",self,"on_back")
	$Descriptor.visible = false
	$lbl_title.text = Lang.get_string("upgrades")
	$btn_menu/Label.text = Lang.get_string("back_to_main")
	#Saves.savedData.days = 50
	update_ui()

func update_ui():
	$lbl_days.text = str(Saves.savedData.days)
	for upg in $Grid.get_children():
		$Grid.remove_child(upg)
		upg.queue_free()
	
	for code in UpgradeData.UPGRADES.keys():
		var upg = preload("res://prefabs/Upgrade.tscn").instance()
		$Grid.add_child(upg)
		upg.connect("mouse_entered",self,"on_mouse_entered",[upg])
		upg.connect("mouse_exited",self,"on_mouse_exited",[upg])
		upg.connect("button_down",self,"on_button_down",[upg])
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
	$Descriptor/LabelCost.text = str(UpgradeData.get_upg_data(upg_node.code).cost)

func on_mouse_exited(upg_node):
	if(!is_instance_valid(upg_node) || upg_node.modulate.a<1): return
	upg_node.unselect()
	if upg_node==current_selected: 
		current_selected = null
		$Descriptor.visible = false

func on_button_down(upg_node):
	if(Saves.savedData.upgrades.find(upg_node.code)!=-1): return
	if(upg_node.modulate.a<1): return
	if(Saves.savedData.days<UpgradeData.get_upg_data(upg_node.code).cost): return
	Saves.savedData.days -= UpgradeData.get_upg_data(upg_node.code).cost
	UpgradeData.add_upgrade(upg_node.code)
	Saves.save_store_data()
	Sounds.play_sound("button1")
	update_ui()

func on_back():
	Sounds.play_sound("button1")
	get_tree().change_scene("res://scenes/Menu.tscn")
