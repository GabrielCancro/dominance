extends Button

var cards = []

# Called when the node enters the scene tree for the first time.
func _ready():
	CardData.DiscardNode = self
	cards.shuffle()
	$Label.text = str( cards.size() )

func add_card(code):
	cards.append(code)
	$Label.text = str( cards.size() )

func pull_card():
	var c = cards.pop_front()
	$Label.text = str( cards.size() )
	return c
