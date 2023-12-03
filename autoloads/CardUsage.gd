extends Node

signal end_use_card()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func use_default_card(code):
	print(code)
	emit_signal("end_use_card")

func use_card_soldier(code):
	get_node("/root/Game/Map").show_create_unit_ui("soldier")
