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
	data = _data.duplicate(true)
	$Image.texture = data.img

func on_mouse_enter():
	UnitManager.show_unit_description(self)

func on_mouse_exit():
	UnitManager.hide_unit_description(self)

func damage(dam):
	data.hp -= dam
	Sounds.play_sound("hit1")
	Effects.shake(self,1,.3)
	Effects.colorization(self,Color(1,.2,.2,1))
	if data.hp<=0: 
		yield(get_tree().create_timer(.5),"timeout")
		Effects.disappear(self)
