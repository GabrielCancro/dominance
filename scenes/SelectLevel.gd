extends Control

func _ready():
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
		node.update_connected_states()

func _exit_tree():
	save_levelPath()
