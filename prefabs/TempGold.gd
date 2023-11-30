extends HBoxContainer

var gold = 0

func _ready():
	set_gold(0)

func set_gold(val):
	gold = val
	for g in get_children():
		g.visible = (g.get_index()<gold)

func add_gold(val):
	set_gold(gold+val)
