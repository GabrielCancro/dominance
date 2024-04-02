extends Control

signal end_magic

func _ready():
	visible = false

func start_magic(unit):
	Sounds.play_sound("fire1")
	rect_position = unit.rect_position
	yield(get_tree().create_timer(.1),"timeout")
	visible = true
	$AnimatedSprite.frame = 0
	$AnimatedSprite.play("default")
	Effects.shake(self)
	yield(get_tree().create_timer(.8),"timeout")
	Effects.to_alpha(self,0)
	Effects.to_scale(self,1.2)
	yield(get_tree().create_timer(.3),"timeout")
	unit.damage(2)
	yield(get_tree().create_timer(.2),"timeout")

	for x in range(3):
		for y in range(3):
			if x==1 && y==1: continue
			var u = get_node("/root/Game/Map").check_unit_pos(unit.map_position+Vector2(x-1,y-1))
			if u: u.damage(1)

	yield(get_tree().create_timer(.4),"timeout")
	emit_signal("end_magic")
	queue_free()
