extends Control

var map_position = Vector2(0,0)
var data

func _ready():
	randomize()
	$AnimationPlayer.play("Idle")
	$AnimationPlayer.seek( randf() )

func set_data(_data):
	data = _data
	$Image.texture = data.img
