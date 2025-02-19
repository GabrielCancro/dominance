extends Control

var LevelData 

func _ready():
	visible = false

func show_level_data(node):
	if node.state<1: return
	if node.type!=0: return
	if !node.name in LevelManager.LEVELS: return
	LevelData = LevelManager.LEVELS[node.name]
	$Panel/Desc.text = str(LevelData.total_days)+" days"
	$Panel/Desc.text += "\nground 3x"+str(LevelData.grid_size)
	$Panel/Desc.text += "\n"+get_weather()
	$Panel/Desc.text += "\n"+"mostly slimes"
	visible = true

func get_weather():
	var s = "good weather"
	if "rain" in LevelData: s= "rain"
	if "fog" in LevelData && "fog" in LevelData: s= "rain and fog"
	return s
