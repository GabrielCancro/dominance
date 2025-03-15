extends Control

var delay = 0
func _ready():
	modulate.a = 0
	yield(get_tree().create_timer(.05+delay),"timeout")
	Sounds.play_sound("sunpoint")
	$Tween.interpolate_property(self,"modulate:a",1,0,.7,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.interpolate_property(self,"rect_global_position",null,Vector2(0,0),.8,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.interpolate_property(self,"rect_scale",Vector2(1.2,1.2),Vector2(1,1),.7,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")
	Effects.emit_signal("add_sunpoints_effect_end")
