extends Control

var amount = 1
var units = 0

func _ready():
	$LowHouseLabel.visible = false
	_update_houses()

func add_house():
	if is_max():
		show_max_house()
		return false
	Sounds.play_sound("build1")
	amount += 1
	_update_houses(true)
	return true

func _update_houses(fx=false,delay=0):
	if delay>0: yield(get_tree().create_timer(delay),"timeout")
	units = get_node("/root/Game/Map").get_units_amount_team(1)
	$MaxLabel.text = str(units)+"/"+str(amount)
	var last
	for h in $Builds.get_children():
		h.visible = (h.get_index()<amount)
		if h.visible: last = h
	if fx: Effects.scaled_from(last)

func is_max():
	return (amount>=6)

func show_low_house():
	if($LowHouseLabel.visible): return
	$LowHouseLabel.visible = true
	Sounds.play_sound("fail1")
	Effects.shake($LowHouseLabel,2,.7)
	yield(get_tree().create_timer(.7),"timeout")
	$LowHouseLabel.visible = false

func show_max_house():
	Sounds.play_sound("fail1")
	Effects.shake($MaxLabel,2,.7)
