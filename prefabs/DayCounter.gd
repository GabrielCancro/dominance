extends Control

var day = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_day():
	day += 1
	$Label.text = str(day)
	Effects.scaled_from(self)
