extends TextureRect

var delay = 0
func _ready():
	modulate.a = 0
	$Tween.interpolate_property(self,"modulate:a",1,0,.7,Tween.TRANS_QUAD,Tween.EASE_OUT,delay)
	$Tween.interpolate_property(self,"rect_global_position",null,Vector2(0,0),.8,Tween.TRANS_LINEAR,Tween.EASE_OUT,delay)
	$Tween.interpolate_property(self,"rect_scale",Vector2(1.2,1.2),Vector2(1,1),.7,Tween.TRANS_LINEAR,Tween.EASE_OUT,delay)
	$Tween.start()
