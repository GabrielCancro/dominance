extends Control

var day = 0
var level = 1
var max_days = 0
var no_created_monsters = []

func _ready():
	level = Saves.savedData.level
	Global.tuto = (level==1)
	max_days = 21 + (level-1)*5
	if max_days>41: max_days = 41
	$TextureProgress/Label4.text = str(max_days-1)
	$TextureProgress.value = 9999

func add_day():
	Effects.scaled_from($TextureProgress)
	if day>=max_days: 
		$TextureProgress/Label4.text = ""
		return
	day += 1
	create_no_created_monsters()
	add_rand_enemies()
	$Label.text = str(day)
	$TextureProgress/Label4.text = str(max_days-day)
	$TextureProgress.max_value = max_days
	#$TextureProgress.value = day

func create_no_created_monsters():
	var new_no_created_monsters = []
	for m in no_created_monsters:
		var created = get_node("../Map").add_enemy_rnd_line(m)
		if !created: new_no_created_monsters.append(m)
	no_created_monsters = new_no_created_monsters

func add_rand_enemies():
	if Global.tuto && day==2: add_enemy(["slime_small"])
	if level==1:
		if day%3==0: add_enemy(["slime_small"])
	elif level==2:
		if day==2: add_enemy(["slime_small"])
		if day==10: add_enemy(["slime_small","slime"])
		if day%4==0: add_enemy(["slime_small"])
		if day%7==0: add_enemy(["slime"])
	elif level==3:
		if day==6: add_enemy(["wolf"])
		if day==10: add_enemy(["wolf"])
		if day==18: add_enemy(["wolf"])
		if day%4==0: add_enemy(["slime","slime_small"])
		if day%7==0: add_enemy(["slime_small","slime","wolf"])
	elif level==4:
		if day%3==0: add_enemy(["slime","slime_small"])
		if day%7==0: add_enemy(["slime","wolf"])
		if day%15==0: add_enemy(["slime_big"])
	elif level==5:
		if day==1: add_enemy(["slime_small"])
		if day==10: add_enemy(["orc"])
		if day==18: add_enemy(["orc"])
		if day%3==0: add_enemy(["slime","slime_small"])
		if day%7==0: add_enemy(["slime","wolf"])
		if day%15==0: add_enemy(["slime_big","orc"])
	else:
		if day%3==0: add_enemy(["slime_small","wolf"])
		if day%5==0: add_enemy(["slime","wolf"])
		if day%9==0: add_enemy(["slime_big","orc"])

func add_enemy(arr):
	arr.shuffle()
	var created = get_node("../Map").add_enemy_rnd_line(arr[0])
	if !created: no_created_monsters.append(arr[0])
