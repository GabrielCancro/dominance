extends TextureRect

func _ready():
	modulate.a = 0
	$Tween.interpolate_property(self,"modulate:a",0,.5,1,Tween.TRANS_QUAD,Tween.EASE_IN_OUT,0)
	$Tween.interpolate_property(self,"rect_global_position",null,to_pos,3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,0)
	$Tween.interpolate_property(self,"rect_scale",Vector2(1,1),Vector2(1.2,1.2),3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,0)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	queue_free()

