extends Control

var gold = 0
var showing_low_gold = 0
onready var showing_low_gold_start_pos = $LowGoldLabel.rect_position

func _ready():
	set_gold(0)

func _process(delta):
	showing_low_gold -= delta
	$LowGoldLabel.rect_position = showing_low_gold_start_pos + Vector2(rand_range(-2,2),0)
	$LowGoldLabel.visible = (showing_low_gold>0)

func set_gold(val):
	gold = val
	for g in $GoldBox.get_children():
		g.visible = (g.get_index()<gold)

func add_gold(val):
	set_gold(gold+val)

func show_low_gold():
	showing_low_gold = .7
