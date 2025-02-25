extends Control

func _ready():
	$Panel.visible = false
	for btn in $HBox.get_children():
		btn.connect("mouse_entered",self,"on_mouse_hover",[btn,true])
		btn.connect("mouse_exited",self,"on_mouse_hover",[btn,false])
		btn.visible = false

func show_fog():
	$Fog.modulate.a = 0
	Effects.to_alpha_slow($Fog,1)
	$Fog.visible = true
	$HBox/btn_fog.visible = true

func show_rain():
	$Rain.modulate.a = 0
	Effects.to_alpha_slow($Rain,1)
	$Rain.visible = true
	$HBox/btn_rain.visible = true

func add_web_card():
	get_node("/root/Game/RegionBottom/Deck").add_card("cobweb",true)
	var node = preload("res://prefabs/effects/fx_cobweb_fade.tscn").instance()
	get_node("/root/Game/RegionBottom").add_child(node)
	$HBox/btn_web.visible = true

func on_mouse_hover(btn,val):
	if val:
		$Panel/Desc.text = Lang.get_string("eventmap_"+btn.name)
		btn.modulate = Color(.9,.9,1,1)
		$Panel.rect_global_position.x = btn.rect_global_position.x+btn.rect_size.x/2-$Panel.rect_size.x/2
		$Panel.visible = true
	else:
		btn.modulate = Color(1,1,1,1)
		$Panel.visible = false
