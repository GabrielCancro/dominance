extends Control

var gold = 0

func _ready():
	set_gold(0)

func set_gold(val):
	gold = val
	for g in $GoldBox.get_children():
		g.visible = (g.get_index()<gold)

func add_gold(val):
	if val>0: Sounds.play_sound("coin1")
	set_gold(gold+val)

func show_low_gold():
	if($LowGoldLabel.visible): return
	$LowGoldLabel.visible = true
	Sounds.play_sound("fail1")
	Effects.shake($LowGoldLabel,2,.7)
	yield(get_tree().create_timer(.7),"timeout")
	$LowGoldLabel.visible = false
