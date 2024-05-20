extends Node

@onready var parent : Node2D = get_parent()
@onready var originalOffset : Vector2 = parent.offset

const NOISE_X = 1
const NOISE_Y = 1

var cameraShakeTime : float = 0

func Initialize():
	SetCameraShakeTime(0)
	parent.offset = originalOffset

func SetCameraShakeTime(_time : float):
	cameraShakeTime = _time

func shake():
	parent.offset.x = NOISE_X * randf_range(-1, 1) * cameraShakeTime
	parent.offset.y = NOISE_Y * randf_range(-1, 1) * cameraShakeTime

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Gvar.Gamemode == Gvar.GamemodeEnum.Play and cameraShakeTime > 0 :
		cameraShakeTime = max(0, cameraShakeTime - delta)
		shake()
	elif Gvar.Gamemode == Gvar.GamemodeEnum.Play and cameraShakeTime == 0 :
		parent.offset = originalOffset
	pass
