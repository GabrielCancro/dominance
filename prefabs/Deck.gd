extends Button

#var cards = ["soldier","soldier","market","gold","gold","gold","wind"]
var cards = ["wind","soldier","market","gold","gold","teasure","house"]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	CardData.DeckNode = self
	cards.shuffle()
	update_ui()

func add_card(code):
	cards.append(code)
	update_ui()

func pull_card():
	var c = cards.pop_front()
	update_ui()
	return c

func set_card_array(arr):
	cards = arr
	cards.shuffle()
	update_ui()

func update_ui():
	$Label.text = str( cards.size() )
	visible = !cards.empty()
