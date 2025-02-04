extends Control

func _ready():
	update_add_sunpoint()

func levelpath_click(node):
	print(node.name)

func update_add_sunpoint(val=0):
	Saves.savedData.days+=val
	$UI/lbl_sunpoints.text = str(Saves.savedData.days)
