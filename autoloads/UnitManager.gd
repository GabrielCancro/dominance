extends Node

var unit_descriptor
var TowerNode
var UnitData = {
	"slime":{"atk":2,"hp":3,"spd":1, "img":null}
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
	var unit_node = preload("res://prefabs/Enemy.tscn").instance()
	unit_node.set_data( UnitData[code] )
	return unit_node

func show_unit_description(unit_node):
	unit_descriptor.set_target(unit_node)
	unit_descriptor.show_panel()

func hide_unit_description(unit_node):
	if unit_descriptor && unit_descriptor.unit_target == unit_node:
		unit_descriptor.hide_panel()

func attack_tower(unit_node):
	TowerNode.add_hp(-unit_node.data.atk)
