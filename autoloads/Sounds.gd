extends Node

var scene

func _ready():
	preload("res://assets/sfx/music01.ogg")
	preload("res://assets/sfx/ambient.mp3")
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
