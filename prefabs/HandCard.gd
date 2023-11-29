extends Button

var toScale = .75
onready var start_position = rect_position
onready var toPosition = rect_position

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("mouse_entered",self,"on_enter_mouse")
	connect("mouse_exited",self,"on_exit_mouse")
	on_exit_mouse()

func _process(delta):
	rect_scale += (Vector2(toScale,toScale)-rect_scale)*delta*10
	rect_position += (toPosition-rect_position)*delta*10
	
func on_enter_mouse():
	toScale = 1
	toPosition = start_position+Vector2(0,-100)

func on_exit_mouse():
	toScale = .75
	toPosition = start_position
