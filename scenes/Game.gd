extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Sounds.set_audio_scene(self)
	CardData.HandBoxNode = $RegionBottom/HandCards
	Global.StopMouseNode = $StopMouse
	$EndTurn.connect("button_down",self,"on_end_turn")
	$QuitGame.connect("button_down",self,"on_quit_game")
	$BtnMarket.connect("button_down",self,"on_click_market")
	Global.set_stop_mouse(true)
	$EndTurn.modulate = Color(1,1,1,.15)
	$EndTurn/Label.text = Lang.get_string("end_turn_button")
	$RegionBottom/DiscardSlot/Label.text = Lang.get_string("discards_slot")

func start_game():
	CardData.init_card_manager()
	yield(get_tree().create_timer(.5),"timeout")
	UpgradeData.apply_upgrades()
	yield(UpgradeData,"end_apply_upgrades")
	yield(get_tree().create_timer(.5),"timeout")
	start_new_turn()

func on_end_turn():
	Sounds.play_sound("button1")
	Global.set_stop_mouse(true)
	$EndTurn.modulate = Color(1,1,1,.15)
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
	yield(get_tree().create_timer(.5),"timeout")
	$Map.move_enemies()
	yield($Map,"end_all_moves")
	yield(get_tree().create_timer(.5),"timeout")
	if check_win(): return
	start_new_turn()

func start_new_turn():
	Sounds.play_sound("turn1")
	$DayCounter.add_day()
	yield(get_tree().create_timer(1),"timeout")
	if(Saves.savedData.upgrades.find("upg6")!=-1 && $DayCounter.day%5==0):
		$RegionBottom/Stash.add_stash_gold(1)
		yield(get_tree().create_timer(1),"timeout")
	$EndTurn.modulate = Color(1,1,1,1)
	CardData.get_cards()

func on_click_market():
	$Market.show_market()

func on_quit_game():
	Sounds.play_sound("button1")
	$ExitBattlePopup.show_popup()

func check_win():
	if $DayCounter.day>=$DayCounter.max_days && $Map.get_units_amount_team(2)<=0:
		$EndPopup.show_popup(true)
		return true
	return false
