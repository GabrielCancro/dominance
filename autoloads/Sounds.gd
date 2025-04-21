extends Node

var scene

func _ready():
	load("res://assets/sfx/music01.ogg")
	load("res://assets/sfx/ambient.mp3")
	pass

func set_audio_scene(_scene):
	scene = _scene

func play_sound(id):
	var audio = AudioStreamPlayer.new()
	add_child(audio)
	audio.stream = load("res://assets/sfx/"+id+".ogg")
	audio.play()
	yield(audio,"finished")
	audio.queue_free()

func set_vol(val):
	var db = (val-100)*0.33
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, db )
	AudioServer.set_bus_mute(bus_index, (val==0) )
