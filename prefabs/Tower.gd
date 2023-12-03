extends Control

var hp = 25
var hpm = 25

func _ready():
	UnitManager.TowerNode = self
	add_hp(0)

func add_hp(val=1):
	if(val<0): Effects.shake($Image,2,.3)
	hp = min(hpm, hp+val)
	$hp.text = str(hp)+"/"+str(hpm)

func damage(dam):
	hp -= dam
	Effects.shake(self,1,.3)
	Effects.colorization(self,Color(1,.2,.2,1))
	$hp.text = str(hp)+"/"+str(hpm)
	if hp<=0: 
		yield(get_tree().create_timer(.5),"timeout")
		Effects.disappear(self)
