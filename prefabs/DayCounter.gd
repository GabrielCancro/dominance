extends Control

var day = 0
var level = 1
var max_days = 0

var no_created_monsters = []
var monsters = [
	{"day":1,"units":["slime"]},
	{"day":2,"units":["slime_small"]},
	{"day":4,"units":["slime","slime_small"]},
	{"day":6,"units":["slime"]},
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
	level = Saves.savedData.level
	max_days = 20 + (level-1)*10
	$Label2.text = str(max_days)

func add_day():
	Effects.scaled_from($Image)
	check_win()
	if day>=max_days: return
	day += 1
	create_no_created_monsters()
#	create_monsters()
	add_rand_enemies()
	$Label.text = str(day)

#func create_monsters():
#	if monsters.empty(): return
#	if monsters[0].day<=day:
#		for m in monsters[0].units: 
#			var created = get_node("../Map").add_enemy_rnd_line(m)
#			if !created: no_created_monsters.append(m)
#		monsters.pop_front()
#	print(monsters)

func create_no_created_monsters():
	var new_no_created_monsters = []
	for m in no_created_monsters:
		var created = get_node("../Map").add_enemy_rnd_line(m)
		if !created: new_no_created_monsters.append(m)
	no_created_monsters = new_no_created_monsters

func check_win():
	if day>=max_days && get_node("../Map").get_units_amount_team()<=0:
		get_node("../EndPopup").show_popup(true)

func add_rand_enemies():
	if day%2==0 || day%3==0:
		var arr = ["slime","slime_small"].shuffle()
		var created = get_node("../Map").add_enemy_rnd_line(arr[0])
		if !created: no_created_monsters.append(arr[0])
	if day%10==0:
		var created = get_node("../Map").add_enemy_rnd_line("slime_big")
		if !created: no_created_monsters.append("slime_big")
	if level>=3 && day%16==0:
		var created = get_node("../Map").add_enemy_rnd_line("slime_big")
		if !created: no_created_monsters.append("slime_big")
