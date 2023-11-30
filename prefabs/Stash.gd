extends Button

var stash_gold = 5

func _ready():
	add_stash_gold(0)
	Effects.add_mouse_focuser(self,$BorderColor)
	connect("button_down",self,"on_click")

func add_stash_gold(val=1):
	stash_gold += val
	$GoldLabel.text = "x"+str(stash_gold)
	$EmptyLabel.visible = (stash_gold<=0)
	$GoldLabel.visible = (stash_gold>0)

func on_click():
	if stash_gold>0:
		add_stash_gold(-1)
		CardData.TempGoldNode.add_gold(1)
