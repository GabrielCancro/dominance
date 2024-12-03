extends HSlider

func _process(delta):
	$hand.rect_position.x = rect_size.x * 0.95 * 0.01 * value - $hand.rect_size.x / 2
