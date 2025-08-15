extends Control

var current_selected
var points

func _ready():
	randomize()
	points = Saves.savedData.days
	Effects.simple_hover_fx($btn_menu)
	Effects.simple_hover_fx($btn_start)
	$btn_menu.connect("button_down",self,"on_back")
	$btn_start.connect("button_down",self,"on_start")
	$Descriptor.visible = false
	$lbl_title.text = Lang.get_string("select_start_build")
	$lbl_title.text += " "+LevelManager.current_level_data.name
	$btn_menu/Label.text = Lang.get_string("back_to_main")
	$btn_start/lbl_title.text = Lang.get_string("play")
	update_ui()

func update_ui():
	$lbl_days.text = str(points)
	for upg in $Grid.get_children():
		$Grid.remove_child(upg)
		upg.queue_free()
	
	for code in UpgradeData.UPGRADES.keys():
		var upg = load("res://prefabs/UpgradeNew.tscn").instance()
		$Grid.add_child(upg)
		upg.connect("mouse_entered",self,"on_mouse_entered",[upg])
		upg.connect("mouse_exited",self,"on_mouse_exited",[upg])
		upg.connect("button_down",self,"on_button_down",[upg])
		upg.set_data(code)
		if (Saves.savedData.upgrades_unlocked.find(code)!=-1): upg.modulate = Color(1,1,1,1)
		else: upg.modulate = Color(.1,.1,.1,.5)

func on_mouse_entered(upg_node):
	if(upg_node.modulate.a<1): return
	if current_selected: on_mouse_exited(current_selected)
	current_selected = upg_node
	upg_node.set_hover(true)
	$Descriptor.visible = true
	$Descriptor/Label.text = UpgradeData.get_upg_data(upg_node.code).desc
	$Descriptor/LabelCost.text = str(UpgradeData.get_upg_data(upg_node.code).cost)

func on_mouse_exited(upg_node):
	if(!is_instance_valid(upg_node) || upg_node.modulate.a<1): return
	upg_node.set_hover(false)
	if upg_node==current_selected: 
		current_selected = null
		$Descriptor.visible = false

func on_button_down(upg_node):
	if(upg_node.modulate.a<1): return
	if(current_selected!=upg_node): return
	
	if upg_node.chossen:
		upg_node.set_chossen(false)
		points += UpgradeData.get_upg_data(upg_node.code).cost
	else:
		if(points<UpgradeData.get_upg_data(upg_node.code).cost): 
			Effects.shake($lbl_days)
			Sounds.play_sound("fail1")
		else:
			upg_node.set_chossen(true)
			points -= UpgradeData.get_upg_data(upg_node.code).cost
			Effects.rectangle_shine_fx(upg_node)
	Sounds.play_sound("button1")
	$lbl_days.text = str(points)

func on_back():
	Sounds.play_sound("button1")
	get_tree().change_scene("res://scenes/SelectLevel.tscn")

func on_start():
	LevelManager.current_upgrades = []
	for upg_node in $Grid.get_children(): 
		if !upg_node.chossen: continue
		LevelManager.current_upgrades.append(upg_node.code)
	Sounds.play_sound("button1")
	get_tree().change_scene("res://scenes/Game.tscn")

func unlock_new_upgrade():
	var upgs = UpgradeData.get_non_obtained_upgrades()
	if upgs.size()<=0: return
	upgs.shuffle()
	Saves.savedData.upgrades_unlocked.append(upgs[0])
	print("UNLOCKED ",upgs[0])
	Saves.save_store_data()
