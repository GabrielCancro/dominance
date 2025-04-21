extends Node

var unit_descriptor
var TowerNode
var UnitData = {
	"slime":{"sk":"sn","atk":1,"hp":3,"spd":2, "img":null, "team":2},
	"slime_small":{"sk":"ss","atk":1,"hp":2,"spd":2, "img":null, "team":2},
	"slime_big":{"sk":"sb","atk":1,"hp":4,"spd":1, "img":null, "team":2, "range":5},
	"wolf":{"sk":"wf","atk":1,"hp":2,"spd":3, "img":null, "team":2},
	"orc":{"sk":"or","atk":1,"hp":4,"spd":2, "img":null, "team":2},
	"spider":{"sk":"sp","atk":1,"hp":2,"spd":2, "img":null, "team":2},
	
	"militia":{"ml":"sn","atk":1,"hp":2,"spd":1, "img":null, "team":1},
	"soldier":{"sl":"sn","atk":1,"hp":4,"spd":1, "img":null, "team":1},
	"archer":{"sl":"ar","atk":1,"hp":2,"spd":1, "img":null, "team":1, "range":7},
}

func _ready():
	init_units()

func init_units():
	for k in UnitData.keys():
		var data = UnitData[k]
		data.name = k
		data.hpm = data.hp
		data.img = load("res://assets/units/"+k+".png")

func create_new_unit(code):
	var unit_node = load("res://prefabs/Unit.tscn").instance()
	unit_node.set_data( UnitData[code] )
	return unit_node

func show_unit_description(unit_node):
	unit_descriptor.set_target(unit_node)
	unit_descriptor.show_panel()

func hide_unit_description(unit_node):
	if unit_descriptor && unit_descriptor.unit_target == unit_node:
		unit_descriptor.hide_panel()

func get_name_by_smallkeys(sk):
	for u in UnitData:
		if sk==UnitData[u].sk: return UnitData[u].name
