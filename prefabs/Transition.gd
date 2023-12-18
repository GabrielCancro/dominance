extends Control

var tween = Tween.new()

func _ready():
	visible = true
	add_child(tween)
	tween.interpolate_property(self,"modulate:a",1,0,.5,Tween.TRANS_QUAD,Tween.EASE_IN)
	tween.start()
	yield(get_tree().create_timer(.5),"timeout")
	visible = false

func fade():
	visible = true
	tween.interpolate_property(self,"modulate:a",0,1,.5,Tween.TRANS_QUAD,Tween.EASE_IN)
	tween.start()
