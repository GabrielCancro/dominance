extends Control

func _ready():
	pass

func start_magic(unit):
	rect_position = unit.rect_position
	$AnimatedSprite.play("default")
	yield($AnimatedSprite,"animation_finished")
	queue_free()
