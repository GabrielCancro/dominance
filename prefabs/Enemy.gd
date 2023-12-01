extends Control

var map_position = Vector2(0,0)
var data

func _ready():
	randomize()
	$AnimationPlayer.play("Idle")
	$AnimationPlayer.seek( randf() )
	$EnemyArea.connect("mouse_entered",self,"on_mouse_enter")
	$EnemyArea.connect("mouse_exited",self,"on_mouse_exit")

func set_data(_data):
	data = _data
	$Image.texture = data.img

func on_mouse_enter():
	UnitManager.show_unit_description(self)

func on_mouse_exit():
	UnitManager.hide_unit_description(self)
