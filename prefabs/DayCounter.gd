extends Control

var day = 0
var level = 1
var max_days = 0
var no_created_monsters = []

func _ready():
	level = Saves.savedData.level
	Global.tuto = (level==1 && Saves.savedData.days == 0)
	max_days = 21 + (level-1)*5
	if max_days>41: max_days = 41
	$TextureProgress/Label4.text = str(max_days-1)
	$TextureProgress.value = 9999

func add_day():
	Effects.scaled_from($TextureProgress)
	if day>=max_days: 
		$TextureProgress/Label4.text = ""
		return
	day += 1
	LevelManager.create_no_created_monsters()
	LevelManager.create_monsters()
	$Label.text = str(day)
	$TextureProgress/Label4.text = str(max_days-day)
	$TextureProgress.max_value = max_days
	#$TextureProgress.value = day
