extends TextureRect

var start_position
var mov = 100
var images = ["chest","explode","gold1","house","market","militia","thundre","soldier","wind"]

func _ready():
	randomize()
	modulate.a = 0
	yield(get_tree().create_timer(1.5),"timeout")
	start_position = rect_global_position
	play_new_ico()

func play_new_ico():
	$Tween.remove_all()
	yield(get_tree().create_timer(rand_range(0,.5)),"timeout")
	texture = load("res://assets/ico_cards/"+images[randi()%images.size()]+".png")
	rect_global_position = start_position
	var to_pos = start_position + Vector2(rand_range(-mov,mov),rand_range(-mov,mov))
	$Tween.interpolate_property(self,"modulate:a",0,.5,1,Tween.TRANS_QUAD,Tween.EASE_IN_OUT,0)
	$Tween.interpolate_property(self,"modulate:a",.5,0,1,Tween.TRANS_QUAD,Tween.EASE_IN_OUT,2)
	$Tween.interpolate_property(self,"rect_global_position",start_position,to_pos,3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,0)
	$Tween.interpolate_property(self,"rect_scale",Vector2(1,1),Vector2(1.2,1.2),3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,0)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	play_new_ico()
