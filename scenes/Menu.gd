extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	localizate()
	$VBox/btn1.connect("button_down",self,"on_click_button",["start"])
	$VBox/btn2.connect("button_down",self,"on_click_button",["options"])
	#$VBox/btn3.connect("button_down",self,"on_click_button",["fullscreen"])
	$VBox/btn4.connect("button_down",self,"on_click_button",["quit"])
	$UpgradesUIButton.connect("button_down",self,"on_upgrades_click")
	$InvasionUIButton.connect("button_down",self,"on_invasion_click")
	$UpgradesUIButton/Label.text = str(Saves.savedData.days)
	$InvasionUIButton/Label.text = str(Saves.savedData.level)
	if Saves.savedData.level>5: 
		$InvasionUIButton/Label.text = Lang.get_string("endless_mode")+" "+str(Saves.savedData.level-5)
	if Global.main_menu_never_showed==true: first_play_effects()

func first_play_effects():
	Global.main_menu_never_showed = false
	$UpgradesUIButton.modulate.a = 0
	$InvasionUIButton.modulate.a = 0
	$Title.modulate.a = 0
	$VBox.modulate.a = 0
	yield(get_tree().create_timer(.5),"timeout")
	Effects.appear_from_bottom($Title)
	yield(get_tree().create_timer(1.0),"timeout")
	Effects.appear_from_bottom($UpgradesUIButton)
	Effects.appear_from_bottom($InvasionUIButton)
	yield(get_tree().create_timer(.5),"timeout")
	Effects.appear_from_bottom($VBox)

func localizate():
	$VBox/btn1/Label.text = Lang.get_string("menu_start_game")
	$VBox/btn2/Label.text = Lang.get_string("menu_options")
	#$VBox/btn3/Label.text = Lang.get_string("menu_fullscreen")
	$VBox/btn4/Label.text = Lang.get_string("menu_quit")
	$VBox/btn4/Label.text = Lang.get_string("menu_quit")
	$UpgradesUIButton/lbl_title.text = Lang.get_string("menu_upgrades")
	$InvasionUIButton/lbl_title.text = Lang.get_string("menu_invasion")
	$InvasionUIButton/PathBattles.update_level()

func on_click_button(code):
	Sounds.play_sound("button1")
	if code=="start":
		get_tree().change_scene("res://scenes/Game.tscn")
	elif code=="options":
		get_tree().change_scene("res://scenes/Options.tscn")
	elif code=="quit":
		$Transition.fade()
		yield(get_tree().create_timer(.5),"timeout")
		get_tree().quit()

func on_upgrades_click():
	if Saves.savedData.level==1 && Saves.savedData.days == 0:
		$UpgradesUIButton.disabled = true
		Effects.shake($UpgradesUIButton/Label)
		yield(get_tree().create_timer(.8),"timeout")
		$UpgradesUIButton.disabled = false
	else:
		print("CLICK UPGRADES")
		Sounds.play_sound("button1")
		get_tree().change_scene("res://scenes/Upgrade.tscn")

func on_invasion_click():
	$InvasionUIButton.disabled = true
	Effects.scaled_from($VBox/btn1)
	yield(get_tree().create_timer(.5),"timeout")
	$InvasionUIButton.disabled = false
