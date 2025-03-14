extends Node

var current_level_data
var current_upgrades = []
var is_rain = false
var is_fog = false

var no_created_monsters = []

var LEVELS = {
	"P1":{"total_days":15,"grid_size":5},
	"P1m":[
		{"c":"day.2","m":["ss"]},
		{"c":"every.4","m":["ss"]}],

	"P2":{"total_days":20,"grid_size":6},
	"P2m":[ 
		{"c":"day.2","m":["ss"]},
		{"c":"day.4","m":["sn"]},
		{"c":"every.5","m":["ss"]},
		{"c":"every.6","m":["sn"]}],

	"P3":{"total_days":25,"grid_size":7, "rain":6},
	"P3m":[ 
		{"c":"day.2","m":["sn"]},
		{"c":"every.4","m":["wf"]},
		{"c":"every.6","m":["ss"]},
		{"c":"every.7","m":["sn"]}],
	
	"P4":{"total_days":25,"grid_size":7, "rain":3, "fog":2},
	"P4m":[ 
		{"c":"day.2","m":["wf"]},
		{"c":"every.4","m":["wf","ss"]},
		{"c":"every.6","m":["wf"]},
		{"c":"every.8","m":["wf"]}],
	
	"P5":{"total_days":25,"grid_size":7, "rain":3, "fog":2},
	"P5m":[ 
		{"c":"day.2","m":["sn"]},
		{"c":"every.3","m":["wf","ss","sp","sp"]},
		{"c":"every.5","m":["wf","sn","sp"]}],
#	"P3":{"total_days":20,"grid_size":5, "rain":3, "fog":2},
#	"P3m":[ {"c":"day.2","m":["ss"]},{"c":"every.4","m":["ss"]}],

#4- size:7 turns:25 rain enemies:slime_small many wolfs
#5- size:7 turns:25 none enemies:slime_small wolfs slime_normal spider
#6- size:7 turns:25 fog enemies:slime_normal wolfs
#7- size:8 turns:20 fog enemies:spiders
#8- size:8 turns:30 rain enemies:slime_small slime_normal wolf orc
#9- size:8 turns:30 rain fog enemies:slime_small slime_normal wolf orc spider
#10- size:5 turns:20 fog enemies:wolf orc
#11- size:8 turns:30 rain enemies:slime_boss
#12- size:8 turns:30 rain fog enemies:slime_small slime_normal wolf orc spider

}

func _ready():
#	LEVELS["P1m"].append({"c":"day.1","m":["sp"]})
	pass # Replace with function body.

func set_current_level(code):
	no_created_monsters = []
	is_rain = false
	is_fog = false
	current_level_data = LEVELS[code].duplicate()
	current_level_data["name"] = code
	return current_level_data

func create_no_created_monsters():
	var new_no_created_monsters = []
	for m in no_created_monsters:
		var created = get_node("/root/Game/Map").add_enemy_rnd_line(m)
		if !created: new_no_created_monsters.append(m)
	no_created_monsters = new_no_created_monsters

func create_monsters():
#	if Global.tuto && day==2: add_enemy(["slime_small"])
	var day = get_node("/root/Game/DayCounter").day
	var statments = LEVELS[current_level_data.name+"m"]
	for st in statments:
		print(st," DAY ",day)
		var cs = st.c.split(".")
		if cs[0]=="day" && day==int(cs[1]): add_enemy(st.m)
		if cs[0]=="every" && day%int(cs[1])==0: add_enemy(st.m)
#		if day%3==0: add_enemy(["slime_small"])
#	elif level==2:
#		if day==2: add_enemy(["slime_small"])
#		if day==10: add_enemy(["slime_small","slime"])
#		if day%4==0: add_enemy(["slime_small"])
#		if day%7==0: add_enemy(["slime"])
#	elif level==3:
#		if day==6: add_enemy(["wolf"])
#		if day==10: add_enemy(["wolf"])
#		if day==18: add_enemy(["wolf"])
#		if day%4==0: add_enemy(["slime","slime_small"])
#		if day%7==0: add_enemy(["slime_small","slime","wolf"])
#	elif level==4:
#		if day%3==0: add_enemy(["slime","slime_small"])
#		if day%7==0: add_enemy(["slime","wolf"])
#		if day%15==0: add_enemy(["slime_big"])
#	elif level==5:
#		if day==1: add_enemy(["slime_small"])
#		if day==10: add_enemy(["orc"])
#		if day==18: add_enemy(["orc"])
#		if day%3==0: add_enemy(["slime","slime_small"])
#		if day%7==0: add_enemy(["slime","wolf"])
#		if day%15==0: add_enemy(["slime_big","orc"])
#	else:
#		if day%3==0: add_enemy(["slime_small","wolf"])
#		if day%5==0: add_enemy(["slime","wolf"])
#		if day%9==0: add_enemy(["slime_big","orc"])

func add_enemy(arr):
	randomize()
	arr.shuffle()
	var unit_name = UnitManager.get_name_by_smallkeys(arr[0])
	var created = get_node("/root/Game/Map").add_enemy_rnd_line(unit_name)
	if !created: no_created_monsters.append(unit_name)

func check_rain():
	if !"rain" in current_level_data: return false
	var DC = get_node("/root/Game/DayCounter")
	if DC.day >= LevelManager.current_level_data.rain && !is_rain:
		is_rain = true
		get_node("/root/Game/EventsMap").show_rain()
		return true
	return false

func check_fog():
	if !"fog" in current_level_data: return false
	var DC = get_node("/root/Game/DayCounter")
	if DC.day >= LevelManager.current_level_data.fog && !is_rain:
		is_fog = true
		get_node("/root/Game/EventsMap").show_fog()
		return true
	return false

func shot_prob_thunders():
	#return amount of thunders
	if !is_rain: return 0
	randomize()
	var total_delay = 0.0
	for u in get_node("/root/Game/Map/Units").get_children():
		if(randf()>.20): continue
		var dy = rand_range(.3,.6)
		total_delay += dy
		throw_delay_thunder(total_delay,u)
	return total_delay+.5

func throw_delay_thunder(delay,unit):
	var mapNode = get_node("/root/Game/Map")
	var th = preload("res://prefabs/magics/MagicThundre.tscn").instance()
	yield(get_tree().create_timer(delay),"timeout")
	mapNode.add_child(th)
	th.start_magic(unit)

func add_debug_units():
	yield(get_tree().create_timer(.5),"timeout")
	var m = get_node("/root/Game/Map")
#	m.add_unit("spider",4,3)
#	m.add_unit("spider",5,2)
#	m.add_unit("wolf",5,3)
#	m.add_unit("orc",6,2)
#	m.add_unit("slime_small",4,1)
#	m.add_unit("slime_small",4,2)
#	m.add_unit("slime_small",4,3)
#	m.add_unit("slime",7,2)
#	m.add_unit("slime_big",8,1)
#	m.add_unit("wolf",8,3)
#	m.add_unit("militia",1,1)
#	m.add_unit("militia",1,2)
#	m.add_unit("militia",1,3)
#	m.add_unit("militia",2,2)
#	m.add_unit("soldier",2,3)
