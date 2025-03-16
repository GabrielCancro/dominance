extends Control

var first_day = true
var lastDayEnded = false

func _ready():
	Sounds.set_audio_scene(self)
	CardData.HandBoxNode = $RegionBottom/HandCards
	Global.StopMouseNode = $StopMouse
	$EndTurn.connect("button_down",self,"on_end_turn")
	$QuitGame.connect("button_down",self,"on_quit_game")
	Effects.add_mouse_focuser($QuitGame,$QuitGame/BorderColor)
	$HelpGame.connect("button_down",self,"on_help_game")
	Effects.add_mouse_focuser($HelpGame,$HelpGame/BorderColor)
	$BtnMarket.connect("button_down",self,"on_click_market")
	Global.set_stop_mouse(true)
	$EndTurn.modulate = Color(1,1,1,.7)
	$EndTurn/BorderColor/Label.text = Lang.get_string("end_turn_button")
	Effects.add_mouse_focuser($EndTurn,$EndTurn/BorderColor)
	$RegionBottom/DiscardSlot/Label.text = Lang.get_string("discards_slot")
	start_game()

func start_game():
	CardData.init_card_manager()
	yield(get_tree().create_timer(.5),"timeout")
	if !Global.demo: 
		UpgradeData.apply_upgrades()
		yield(UpgradeData,"end_apply_upgrades")
	yield(get_tree().create_timer(.5),"timeout")

	if Global.tuto: tutorial_sequence()
	else: start_new_turn()

func on_end_turn():
	Sounds.play_sound("button1")
	Global.set_stop_mouse(true)
	$EndTurn.modulate = Color(1,1,1,.7)
	if check_win(): return
	for i in range(CardData.hand_cards.size()):
		var c = CardData.hand_cards[i]
		if(is_instance_valid(c)): 
			CardData.DiscardNode.add_card(c.data.code)
			CardData.hand_cards[i] = null
			Effects.disappear(c,Vector2(0,0))
			yield(get_tree().create_timer(.1),"timeout")
	yield(get_tree().create_timer(.5),"timeout")
	CardData.TempGoldNode.set_gold(0)
	$Map.restore_units_attack()
	yield(get_tree().create_timer(.5),"timeout")
	$Map.move_enemies()
	yield($Map,"end_all_moves")
	yield(get_tree().create_timer(.5),"timeout")
	if check_win(): return
	start_new_turn()

func start_new_turn():
	if(first_day):
		first_day = false
	else:
		Sounds.play_sound("turn1")
		$DayCounter.add_day()
	yield(get_tree().create_timer(.5),"timeout")
	var tdl = LevelManager.shot_prob_thunders()
	if tdl>0: yield(get_tree().create_timer(tdl),"timeout")
	yield(get_tree().create_timer(.5),"timeout")
	if(LevelManager.current_upgrades.find("upg_gold_five_days")!=-1 && $DayCounter.day%5==0 && !lastDayEnded):
		$RegionBottom/Stash.add_stash_gold(1)
		yield(get_tree().create_timer(1),"timeout")
	lastDayEnded = ($DayCounter.day==$DayCounter.max_days)
	if LevelManager.check_rain(): yield(get_tree().create_timer(1),"timeout")
	if LevelManager.check_fog(): yield(get_tree().create_timer(1),"timeout")
	$EndTurn.modulate = Color(1,1,1,1)
	if check_win(): return
	CardData.get_cards()

func on_click_market():
	$Market.show_market()

func on_quit_game():
	Sounds.play_sound("button1")
	$ExitBattlePopup.show_popup()

func on_help_game():
	$TutorialPopup.show_tuto("all")

func check_win():
	if $DayCounter.day>=$DayCounter.max_days && $Map.get_units_amount_team(2)<=0:
		if Global.demo: $DemoEndPopup.show_popup(true)
		else: $EndPopup.show_popup(true)
		return true
	return false

func tutorial_sequence():
	Global.set_stop_mouse(true)
	yield(get_tree().create_timer(.5),"timeout")
	$TutorialPopup.show_tuto("tower")
	yield($TutorialPopup,"close_popup")
	yield(get_tree().create_timer(.7),"timeout")
	start_new_turn()

	yield(get_tree().create_timer(3.7),"timeout")
	$TutorialPopup.show_tuto("gold")
	yield($TutorialPopup,"close_popup")
	yield(get_tree().create_timer(.3),"timeout")
	CardData.hand_cards[2].on_mouse_enter()
	CardData.hand_cards[2].on_click_card()

	yield(get_tree().create_timer(2),"timeout")
	$TutorialPopup.show_tuto("gold2")
	yield($TutorialPopup,"close_popup")
	yield(get_tree().create_timer(2),"timeout")

	$TutorialPopup.show_tuto("burn")
	yield($TutorialPopup,"close_popup")
	CardData.hand_cards[1].on_mouse_burn_enter()
	CardData.hand_cards[1].on_click_burn()
	yield(get_tree().create_timer(2),"timeout")

	$TutorialPopup.show_tuto("burn2")
	yield($TutorialPopup,"close_popup")
	CardData.hand_cards[3].on_mouse_burn_enter()
	CardData.hand_cards[3].on_click_burn()
	yield(get_tree().create_timer(2),"timeout")

	$TutorialPopup.show_tuto("milician")
	yield($TutorialPopup,"close_popup")
	CardData.hand_cards[0].on_mouse_enter()
	CardData.hand_cards[0].on_click_card()
	CardData.hide_card_description(CardData.hand_cards[0])
	Global.clear_stop_mouse()
	yield(get_tree().create_timer(.1),"timeout")
	CardData.hide_card_description(CardData.hand_cards[0])
	yield($CreateUnitPanel,"close")
	Global.set_stop_mouse(true)

	yield(get_tree().create_timer(1),"timeout")
	$TutorialPopup.show_tuto("turn")
	yield($TutorialPopup,"close_popup")
	yield(get_tree().create_timer(1),"timeout")
	on_end_turn()

	yield(get_tree().create_timer(6),"timeout")
	$TutorialPopup.show_tuto("enemies")
	yield($TutorialPopup,"close_popup")

	$TutorialPopup.show_tuto("days")
	yield($TutorialPopup,"close_popup")
	Global.clear_stop_mouse()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		Effects.spawn_arrow($RegionBottom/Stash,$EndTurn)
