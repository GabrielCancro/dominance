extends TextureRect

func _ready():
	modulate.a = 0
	rect_global_position = get_node("/root/Game/RegionBottom/DeckSlot").rect_global_position+Vector2(0,-150)
	$Tween.interpolate_property(self,"modulate:a",0,1,.3,Tween.TRANS_QUAD,Tween.EASE_IN_OUT,.5)
	$Tween.interpolate_property(self,"modulate:a",1,0,.5,Tween.TRANS_QUAD,Tween.EASE_IN_OUT,1)
	$Tween.interpolate_property(self,"rect_global_position",rect_global_position,rect_global_position+Vector2(0,+150),.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,1)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	queue_free()
