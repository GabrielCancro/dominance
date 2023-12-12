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
	yield(get_tree().create_timer(1),"timeout")
	start_new_turn()

func on_end_turn():
	Sounds.play_sound("button1")
	Global.set_stop_mouse(true)
	$EndTurn.modulate = Color(1,1,1,.15)
	for i in range(CardData.hand_cards.size()):
		var c = CardData.hand_cards[i]
		if(c!=null): 
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
	start_new_turn()

func start_new_turn():
	Sounds.play_sound("turn1")
	$DayCounter.add_day()
	yield(get_tree().create_timer(1),"timeout")
	$EndTurn.modulate = Color(1,1,1,1)
	CardData.get_cards()
	if $DayCounter.day>1:
		Saves.savedData.days += 1
		if(Saves.savedData.days>20):
			Saves.savedData.days -= 20
			Saves.savedData.points += 1
		Saves.save_store_data()

func on_click_market():
	$Market.show_market()

func on_quit_game():
	get_tree().change_scene("res://scenes/Menu.tscn")
