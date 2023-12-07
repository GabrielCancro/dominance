extends Control

var amount = 1

func _ready():
	$LowHouseLabel.visible = false
	_update_houses()

func add_house():
	if is_max():
		show_max_house()
		return false
	Sounds.play_sound("step1")
	amount += 1
	return true

func _update_houses():
	for h in $Builds.get_children():
		h.visible = (h.get_index()<amount)

func is_max():
	return (amount>=6)

func show_low_house():
	if($LowHouseLabel.visible): return
	$LowHouseLabel.visible = true
	$LowHouseLabel.text = "low houses"
	Sounds.play_sound("fail1")
	Effects.shake($LowHouseLabel,2,.7)
	yield(get_tree().create_timer(.7),"timeout")
	$LowHouseLabel.visible = false

func show_max_house():
	if($LowHouseLabel.visible): return
	$LowHouseLabel.text = "MANY HOUSES!!"
	$LowHouseLabel.visible = true
	Sounds.play_sound("fail1")
	Effects.shake($LowHouseLabel,2,.7)
	yield(get_tree().create_timer(.7),"timeout")
	$LowHouseLabel.visible = false
