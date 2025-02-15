extends Node

var last_version = 32
var default_data = {
	"upgrades_unlocked":[], 
	"resume":null,
	"language":"en",
	"levelpath":{},
	"days":0,
	"fullscreen": true,
	"mvol": 100,
	"version":0
}
var savedData = {}

func _ready():
	load_store_data()

func save_store_data():
	if Global.demo: return
	var file = File.new()
	file.open("user://store_app_data_v2.res", File.WRITE)
	savedData.version = last_version
	file.store_string(var2str(savedData))
	file.close()
	print("SAVE ",savedData)

func load_store_data():  
	savedData = default_data  
	if Global.demo: 
		if("es" in OS.get_locale()): savedData.language = "es"
		return 
	var file = File.new()
	file.open("user://store_app_data_v2.res", File.READ)
	var loaded_data = str2var(file.get_as_text())
	file.close()
	if(!loaded_data): 
		savedData = default_data.duplicate(true)
		if("es" in OS.get_locale()): savedData.language = "es"
		save_store_data()
	
#	not load if is an old version
	if !"version" in savedData: return
	if savedData.version<last_version: return
	
	savedData = loaded_data
	Sounds.set_vol(savedData.mvol)
	print("LOAD ",loaded_data)

func now_date():
	var now = OS.get_date() 
	return str(now.year)+"-"+str(now.month)+"-"+str(now.day)

func clear_data():
	savedData = default_data.duplicate(true)
	save_store_data()
	get_tree().change_scene("res://scenes/Splash.tscn")
	#get_tree().quit()
