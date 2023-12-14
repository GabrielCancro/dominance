extends Control

var day = 0
var max_days = 60

var no_created_monsters = []
var monsters = [
	{"day":1,"units":["slime_small"]},
	{"day":2,"units":["slime"]},
	{"day":4,"units":["slime_small"]},
	{"day":8,"units":["slime_small"]},
	{"day":11,"units":["slime"]},
	{"day":14,"units":["slime_small"]},
	{"day":18,"units":["slime","slime_small"]},
	{"day":22,"units":["slime"]},
	{"day":24,"units":["slime","slime_small"]},
	{"day":26,"units":["slime_small"]},
	{"day":28,"units":["slime"]},
	{"day":30,"units":["slime_small","slime_big"]},

	{"day":38,"units":["slime","slime_small"]},
	{"day":41,"units":["slime"]},
	{"day":44,"units":["slime_small","slime_small"]},
	{"day":48,"units":["slime","slime_big"]},
	{"day":52,"units":["slime"]},
	{"day":54,"units":["slime","slime_small"]},
	{"day":56,"units":["slime_small"]},
	{"day":58,"units":["slime"]},
	{"day":60,"units":["slime_small","slime_small","slime_big","slime_big"]},
]

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
		monsters.pop_front()
	print(monsters)

func create_no_created_monsters():
	var new_no_created_monsters = []
	for m in no_created_monsters:
		var created = get_node("../Map").add_enemy_rnd_line(m)
		if !created: new_no_created_monsters.append(m)
	no_created_monsters = new_no_created_monsters
