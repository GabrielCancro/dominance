extends Control

func _ready():
	#$Button.connect("mouse_entered",self,"on_enter_mouse")
	#$Button.connect("mouse_exited",self,"on_exit_mouse")
	on_exit_mouse()
	update_level()

func update_level():
	for p in $HBoxContainer.get_children():
		if p.get_index()%2!=0: continue
		if p.get_index()/2<=Saves.savedData.level-1:
			p.texture = preload("res://assets/upgrades/CheckFull.png") 
	$LabelInvasion.text = "invasion: "+str(Saves.savedData.level)
	if Saves.savedData.level==5: 
		$LabelInvasion.text = Lang.get_string("end_battle")
	elif Saves.savedData.level>5: 
		$LabelInvasion.text = Lang.get_string("endless_mode")+": "+str(Saves.savedData.level-5)
		$HBoxContainer.modulate = Color(1,.5,.5,.7)

func on_enter_mouse():
	$LabelInvasion.visible = true

func on_exit_mouse():
	$LabelInvasion.visible = false
