extends Node

var UnitData = {
	"slime":{"atk":1,"hp":2,"spd":1, "img":null}
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
