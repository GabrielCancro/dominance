extends Control

var map_position = Vector2(0,0)
var is_dead = false
var data
var hp_timer = 0

func _ready():
	randomize()
	$AnimationPlayer.play("Idle")
	$AnimationPlayer.seek( randf() )
	$UnitArea.connect("mouse_entered",self,"on_mouse_enter")
	$UnitArea.connect("mouse_exited",self,"on_mouse_exit")
	$Hpbar.visible = false

func _process(delta):
	if hp_timer>0: hp_timer -= delta
	$Hpbar.visible = (hp_timer>0)

func set_data(_data):
	data = _data.duplicate(true)
	$Image.texture = data.img
	update_hp()

func on_mouse_enter():
	UnitManager.show_unit_description(self)

func on_mouse_exit():
	UnitManager.hide_unit_description(self)

func damage(dam,check_dead=true):
	data.hp -= dam
	Sounds.play_sound("hit1")
	Effects.shake(self,1,.3)
	Effects.colorization(self,Color(1,.2,.2,1))
	update_hp(true)
	if check_dead: check_dead()

func check_dead():
	if data.hp<=0:
		is_dead = true 
		yield(get_tree().create_timer(.5),"timeout")
		get_node("/root/Game/Houses")._update_houses(false,1)
		Effects.disappear(self)
		CardData.update_cards_warnings()

func update_hp(show=false):
	if show: hp_timer = 1.5
	for h in $Hpbar.get_children():
		h.visible = h.get_index()<data.hpm
		if h.get_index()<data.hp: h.texture = preload("res://assets/heart_m.png")
		else: h.texture = preload("res://assets/heart_slot_m.png")

func add_hp(val):
	data.hp += val
	if data.hp>data.hpm: data.hpm = data.hp
	update_hp(true)
