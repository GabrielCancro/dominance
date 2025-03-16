extends Control

var LevelData 
var LevelEnemies

func _ready():
	visible = false

func show_level_data(node):
	if node.state<1: return
	if node.type!=0: return
	if !node.name in LevelManager.LEVELS: return
	LevelData = LevelManager.LEVELS[node.name]
	LevelEnemies = LevelManager.LEVELS[node.name+"m"]
	$Panel/Desc.text = "Level "+node.name.right(1)
	$Panel/Desc.text += "\n"+str(LevelData.total_days)+" days"
	$Panel/Desc.text += "\nground 3x"+str(LevelData.grid_size)
	$Panel/Desc.text += "\n"+get_weather()
	$Panel/Desc.text += "\n"
	set_enemies()
	visible = true

func get_weather():
	var s = "good weather"
	if "rain" in LevelData: s= "rain"
	if "fog" in LevelData && "fog" in LevelData: s= "rain and fog"
	return s

func set_enemies():
	for en in $HBox.get_children(): en.visible = false
	for c in LevelEnemies: for m in c["m"]: $HBox.get_node(m).visible = true
	var count = 0
	for en in $HBox.get_children(): if en.visible: count += 1
	if count <= 4: $HBox.add_constant_override("separation", -15)
	else: $HBox.add_constant_override("separation", -27)
