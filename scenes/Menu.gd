extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	localizate()
	Effects.simple_hover_fx($VBox/btn1)
	Effects.simple_hover_fx($VBox/btn2)
	Effects.simple_hover_fx($VBox/btn3)
	Effects.simple_hover_fx($VBox/btn4)
	$VBox/btn1.connect("button_down",self,"on_click_button",["start"])
	$VBox/btn2.connect("button_down",self,"on_click_button",["options"])
	$VBox/btn3.connect("button_down",self,"on_click_button",["credits"])
	$VBox/btn4.connect("button_down",self,"on_click_button",["quit"])	
	Effects.simple_hover_fx($UpgradesUIButton)
	Effects.simple_hover_fx($InvasionUIButton)
	$UpgradesUIButton.connect("button_down",self,"on_upgrades_click")
	$InvasionUIButton.connect("button_down",self,"on_invasion_click")
	$UpgradesUIButton/Label.text = str(Saves.savedData.upgrades_unlocked.size())+"/"+str(UpgradeData.UPGRADES.keys().size())
	var winlevels = 0
	var totallevels = 0
	for l in Saves.savedData.levelPath.keys():
		print(l,": ",Saves.savedData.levelPath[l])
		if l.rfind("P")!=-1:
			totallevels += 1
			if Saves.savedData.levelPath[l]>1: winlevels += 1
	$InvasionUIButton/Label.text = str(winlevels)+"/"+str(totallevels)
	first_play_effects()

func first_play_effects():
	if !Global.main_menu_never_showed: return
	Global.main_menu_never_showed = false
	$UpgradesUIButton.modulate.a = 0
	$InvasionUIButton.modulate.a = 0
	$Title.modulate.a = 0
	$VBox.modulate.a = 0
	$VBox.visible = false
	yield(get_tree().create_timer(.5),"timeout")
	Effects.appear_from_bottom($Title)
	yield(get_tree().create_timer(1.0),"timeout")
	Effects.appear_from_bottom($UpgradesUIButton)
	Effects.appear_from_bottom($InvasionUIButton)
	yield(get_tree().create_timer(.5),"timeout")
	$VBox.visible = true
	Effects.appear_from_bottom($VBox)

func localizate():
	$VBox/btn1/Label.text = Lang.get_string("menu_start_game")
	$VBox/btn2/Label.text = Lang.get_string("menu_options")
	$VBox/btn3/Label.text = Lang.get_string("menu_credits")
	$VBox/btn4/Label.text = Lang.get_string("menu_quit")
	$VBox/btn4/Label.text = Lang.get_string("menu_quit")
	$UpgradesUIButton/lbl_title.text = Lang.get_string("menu_upgrades")
	$InvasionUIButton/lbl_title.text = Lang.get_string("menu_invasions")

func on_click_button(code):
	Sounds.play_sound("button1")
	if code=="start":
		get_tree().change_scene("res://scenes/SelectLevel.tscn")
	elif code=="options":
		get_tree().change_scene("res://scenes/Options.tscn")
	elif code=="credits":
		get_tree().change_scene("res://scenes/Credits.tscn")
	elif code=="quit":
		$Transition.fade()
		yield(get_tree().create_timer(.5),"timeout")
		get_tree().quit()

func on_upgrades_click():
	print("CLICK UPGRADES")
	Sounds.play_sound("button1")
	get_tree().change_scene("res://scenes/Upgrade.tscn")

func on_invasion_click():
	$InvasionUIButton.disabled = true
	Effects.scaled_from($VBox/btn1)
	Sounds.play_sound("tum1")
	yield(get_tree().create_timer(.5),"timeout")
	$InvasionUIButton.disabled = false
