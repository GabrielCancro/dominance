extends Control

signal end_magic

func _ready():
	visible = false

func start_magic(unit):
	Sounds.play_sound("fire1")
	yield(get_tree().create_timer(.3),"timeout")
	rect_position = unit.rect_position
	yield(get_tree().create_timer(.2),"timeout")
	visible = true
	$AnimatedSprite.playing = true
	Effects.shake(self)
	yield(get_tree().create_timer(.3),"timeout")
	Effects.to_alpha(self,0)
	yield(get_tree().create_timer(.4),"timeout")
	unit.damage(2)
	yield(get_tree().create_timer(.4),"timeout")
	
	var u = get_node("/root/Game/Map").check_unit_pos(unit.map_position+Vector2(-1,0))
	if u: u.damage(1)
	u = get_node("/root/Game/Map").check_unit_pos(unit.map_position+Vector2(+1,0))
	if u: u.damage(1)
	u = get_node("/root/Game/Map").check_unit_pos(unit.map_position+Vector2(0,-1))
	if u: u.damage(1)
	u = get_node("/root/Game/Map").check_unit_pos(unit.map_position+Vector2(0,+1))
	if u: u.damage(1)
	
	yield(get_tree().create_timer(.4),"timeout")
	emit_signal("end_magic")
	queue_free()
