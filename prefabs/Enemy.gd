extends Control

var steps = 8

func _ready():
	randomize()
	$AnimationPlayer.play("Idle")
	$AnimationPlayer.seek( randf() )
	$EnemyArea.connect("button_down",self,"walk")

func walk():
	if steps<=0: return
	steps -= 1
	var des = rect_global_position - Vector2(64,0)
	Effects.move_to(self,des)
