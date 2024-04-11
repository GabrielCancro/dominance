extends Control

func _ready():
	$Particles2D.emitting = true
	yield(get_tree().create_timer($Particles2D.lifetime),"timeout")
	queue_free()
