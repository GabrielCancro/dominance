extends Node

var default_data = { 
	"upgrades":[], 
	"upgrades_unlocked":[], 
	"resume":null,
	"language":"en",
	"level":1,
	"days":0,
	"fullscreen": true,
	"mvol": 100
}
var savedData = {}

func _ready():
	load_store_data()

func save_store_data():
	if Global.demo: return
	var file = File.new()
	file.open("user://store_app_data_v2.res", File.WRITE)
	file.store_string(var2str(savedData))
	file.close()
	print("SAVE ",savedData)

func load_store_data():    
	if Global.demo: 
		savedData = default_data
		if("es" in OS.get_locale()): savedData.language = "es"
		return 
	var file = File.new()
	file.open("user://store_app_data_v2.res", File.READ)
	var loaded_data = str2var(file.get_as_text())
	file.close()
	#if(loaded_data && loaded_data.size()!=savedData.size()): loaded_data = null
	if(!loaded_data): 
		loaded_data = default_data.duplicate(true)
		if("es" in OS.get_locale()): loaded_data.language = "es"
		save_store_data()
	savedData = loaded_data
	if !savedData.has("level"): savedData.level = 1
	if !savedData.has("mvol"): savedData.mvol = 100
	Sounds.set_vol(savedData.mvol)
	print("LOAD ",loaded_data)
#	savedData.level = 60
#	savedData.days = 100

func now_date():
	var now = OS.get_date() 
	return str(now.year)+"-"+str(now.month)+"-"+str(now.day)

func clear_data():
	savedData = default_data.duplicate(true)
	save_store_data()
	get_tree().change_scene("res://scenes/Splash.tscn")
	#get_tree().quit()
