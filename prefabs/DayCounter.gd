extends Control

var day = 0
var max_days = 30

var no_created_monsters = []
var monsters = [
	{"day":2,"units":["slime"]},
	{"day":4,"units":["slime"]},
	{"day":8,"units":["slime","slime"]},
	{"day":11,"units":["slime"]},
	{"day":14,"units":["slime"]},
	{"day":18,"units":["slime","slime"]},
	{"day":22,"units":["slime","slime"]},
	{"day":24,"units":["slime"]},
	{"day":26,"units":["slime"]},
	{"day":28,"units":["slime","slime"]},
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_day():
	day += 1
	create_no_created_monsters()
	create_monsters()
	$Label.text = str( min(max_days,day) )
	Effects.scaled_from(self)

func create_monsters():
	if monsters.empty(): return
	if monsters[0].day<=day:
		for m in monsters[0].units: 
			var created = get_node("../Map").add_enemy_rnd_line(m)
			if !created: no_created_monsters.append(m)
		monsters.pop_back()
	print(monsters)

func create_no_created_monsters():
	var new_no_created_monsters = []
	for m in no_created_monsters:
		var created = get_node("../Map").add_enemy_rnd_line(m)
		if !created: new_no_created_monsters.append(m)
	no_created_monsters = new_no_created_monsters
