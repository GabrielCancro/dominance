extends Button

var cards = []

# Called when the node enters the scene tree for the first time.
func _ready():
	CardData.DiscardNode = self
	cards.shuffle()
	update_ui()

func add_card(code):
	cards.append(code)
	update_ui()

func pull_card():
	var c = cards.pop_front()
	update_ui()
	return c

func get_all_cards():
	var c = cards.duplicate()
	cards = []
	update_ui()
	return c

func update_ui():
	$Label.text = str( cards.size() )
	visible = !cards.empty()
