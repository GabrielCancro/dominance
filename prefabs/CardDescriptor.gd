extends Control

var card_target

func _ready():
	CardData.card_descriptor = self
	modulate.a = 0
	
func _process(delta):
	if !is_instance_valid(card_target): hide_panel()

func set_target(card_node):
	card_target = card_node
	$Desc.text = Lang.get_card_desc(card_node.data.code)
	rect_global_position = card_node.rect_global_position
	rect_global_position.x -= rect_size.x/2
	rect_global_position.x += card_node.rect_size.x/2
	rect_global_position.y -= 150

func show_panel():
	$Tween.remove_all()
	$Tween.interpolate_property(self,"modulate:a",modulate.a,1,.2)
	$Tween.start()

func hide_panel():
	$Tween.remove_all()
	$Tween.interpolate_property(self,"modulate:a",modulate.a,0,.2)
	$Tween.start()
	yield($Tween,"tween_all_completed")
