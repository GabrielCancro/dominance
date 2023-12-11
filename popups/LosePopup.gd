extends Control

var upgrade_selected
var min_days_to_upgrade = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	$btn_menu.connect("button_down",self,"on_back")
	$Panel/HBox/Upgrade1.connect("on_select",self,"on_upgrade_select")
	$Panel/HBox/Upgrade2.connect("on_select",self,"on_upgrade_select")
	visible = false
	modulate.a = 0
	$Panel.visible = false
	$Panel/HBox/Upgrade1.visible = false
	$Panel/HBox/Upgrade2.visible = false
	$Panel.modulate.a = 0
	$btn_menu.visible = false
	$btn_menu.modulate.a = 0

func show_popup():
	Global.set_stop_mouse(false)
	$ColorRect3/Label.text = Lang.get_string( "lose_game" )
	Effects.to_alpha(self,1)
	visible = true
	yield(get_tree().create_timer(1),"timeout")
	if get_node("/root/Game/DayCounter").day>=min_days_to_upgrade: show_upgrades()
	else: show_end_button()

func show_upgrades():
	$Panel/Label2.text = Lang.get_string( "choose_upg" )
	var arr = (UpgradeData.get_non_obtained_upgrades() as Array)
	arr.shuffle()
	if(arr.size()>0): 
		$Panel/HBox/Upgrade1.set_data( arr.pop_back() )
		$Panel/HBox/Upgrade1.visible = true
		if(arr.size()>0): 
			$Panel/HBox/Upgrade2.set_data( arr.pop_back() )
			$Panel/HBox/Upgrade2.visible = true
	else:
		$Panel/Label2.text = Lang.get_string( "upg_all_obtained" )
		show_end_button()
	Effects.to_alpha($Panel,1)
	$Panel.visible = true

func show_end_button():
	$btn_menu/Label.text = Lang.get_string( "back_to_main" )
	Effects.to_alpha($btn_menu,1)
	$btn_menu.visible = true

func on_upgrade_select(upg_node):
	if upgrade_selected: return
	print("on_upgrade_select!!! ")
	UpgradeData.add_upgrade(upg_node.code)
	Sounds.play_sound("button1")
	upgrade_selected = upg_node
	yield(get_tree().create_timer(.5),"timeout")
	Effects.to_alpha($Panel,0)
	yield(get_tree().create_timer(.7),"timeout")
	show_end_button()

func on_back():
	Sounds.play_sound("button1")
	get_tree().change_scene("res://scenes/Menu.tscn")
