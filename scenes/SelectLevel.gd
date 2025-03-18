extends Control

func _ready():
	$UI/Button.connect("button_down",self,"unlock_all_debug")
	$UI/Button.visible = Global.debug
	$UI/btn_menu.connect("button_down",self,"on_back_click")
	$UI/btn_menu/Label.text = Lang.get_string("back_to_main")
	$UI/lbl_title.text = Lang.get_string("select_level")
	Effects.connect("add_sunpoints_effect_end",self,"add_sunpoints",[1])
	add_sunpoints()
	load_levelPath()

func levelpath_click(node):
	print(node.name)

func add_sunpoints(val=0):
	Saves.savedData.days+=val
	$UI/lbl_sunpoints.text = str(Saves.savedData.days)

func save_levelPath():
	for p in $LevelPath.get_children(): Saves.savedData["levelPath"][p.name] = p.state
	Saves.save_store_data()

func load_levelPath():
	if !"levelPath" in Saves.savedData:  Saves.savedData["levelPath"] = {}
	for name in Saves.savedData["levelPath"].keys():
		var state = Saves.savedData["levelPath"][name]
		var node = $LevelPath.get_node_or_null(name)
		if node: 
			node.state = state
			node.set_type()
	for node in $LevelPath.get_children():
		node.connect("on_hint",self,"level_hint_hover",[node])
		node.update_connected_states()

func _exit_tree():
	save_levelPath()

func level_hint_hover(val,node):
	$UI/LevelHint.rect_global_position = node.global_position + Vector2(0,-15)
	if val: $UI/LevelHint.show_level_data(node)
	else: $UI/LevelHint.visible = false

func unlock_all_debug():
	Sounds.play_sound("button1")
	for node in $LevelPath.get_children():
		if node.state==0: 
			node.state=1
			node.set_type()

func on_back_click():
	Sounds.play_sound("button1")
	get_tree().change_scene("res://scenes/Menu.tscn")
