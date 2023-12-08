extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Sounds.set_audio_scene(self)
	CardData.HandBoxNode = $RegionBottom/HandCards
	Global.StopMouseNode = $StopMouse
	#CardUsage.connect("end_use_card",self,"check_empty_hand")
	#CardData.connect("burn_card",self,"check_empty_hand")
	$EndTurn.connect("button_down",self,"on_end_turn")
	$BtnMarket.connect("button_down",self,"on_click_market")
	Global.set_stop_mouse(true)
	yield(get_tree().create_timer(1),"timeout")
	start_new_turn()

#func check_empty_hand():
#	for i in range(CardData.hand_cards.size()): 
#		if(CardData.hand_cards[i]!=null): return
#	yield(get_tree().create_timer(1),"timeout")
#	CardData.TempGoldNode.set_gold(0)
#	yield(get_tree().create_timer(1),"timeout")
#	CardData.get_cards() 

func on_end_turn():
	Global.set_stop_mouse(true)
	$EndTurn.modulate = Color(.3,.3,.3,.3)
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
	

func on_click_market():
	$Market.show_market()
