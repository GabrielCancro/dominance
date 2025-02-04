extends Control

func _ready():
	Effects.connect("add_sunpoints_effect_end",self,"add_sunpoints",[1])
	add_sunpoints()

func levelpath_click(node):
	print(node.name)

func add_sunpoints(val=0):
	Saves.savedData.days+=val
	$UI/lbl_sunpoints.text = str(Saves.savedData.days)
