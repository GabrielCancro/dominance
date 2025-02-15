extends Control

var unit_target

func _ready():
	UnitManager.unit_descriptor = self
	modulate.a = 0

func set_target(unit_node):
	unit_target = unit_node
	$atk.text = str(unit_node.data.atk)
	$hp.text = str(unit_node.data.hp)
	rect_global_position = unit_node.rect_global_position
	rect_global_position.x -= rect_size.x/2
	rect_global_position.x += unit_node.rect_size.x/2
	rect_global_position.y -= 80

func show_panel():
	$Tween.remove_all()
	$Tween.interpolate_property(self,"modulate:a",modulate.a,1,.1)
	$Tween.start()

func hide_panel():
	$Tween.remove_all()
	$Tween.interpolate_property(self,"modulate:a",modulate.a,0,.1)
	$Tween.start()
	yield($Tween,"tween_all_completed")
