extends Control

signal end_magic

func _ready():
	visible = false

func start_magic(unit):
	yield(get_tree().create_timer(.3),"timeout")
	rect_position = unit.rect_position
	yield(get_tree().create_timer(.2),"timeout")
	visible = true
	Sounds.play_sound("thundre1")
	Effects.shine(unit)
	Effects.shine(self)
	Effects.shake(self)
	yield(get_tree().create_timer(.3),"timeout")
	Effects.to_alpha(self,0)
	yield(get_tree().create_timer(.6),"timeout")
	unit.damage(1)
	yield(get_tree().create_timer(.5),"timeout")
	emit_signal("end_magic")
	queue_free()
