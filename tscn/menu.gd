extends CanvasLayer

const VBOXCONTAINER_ITEM_COUNT = 4

var parent : Node2D
var currentIndex : int = 0

func Select(_input : int):
	play_sound()
	if(0 < _input):
		currentIndex += 1
		currentIndex = fposmod(currentIndex, VBOXCONTAINER_ITEM_COUNT)
		_select(currentIndex)
	elif(_input < 0):
		currentIndex -= 1
		currentIndex = fposmod(currentIndex, VBOXCONTAINER_ITEM_COUNT)
		_select(currentIndex)
	elif(_input == 0):
		match(currentIndex):
			0:
				parent.Resume()
			1:
				parent.Restart()
			2:
				parent.Setting()
			3:
				parent.Title()
				
		

func __initiateSelectColor():
	$VBoxContainer/Resume.add_theme_color_override("font_color", Color.WHITE)
	$VBoxContainer/Restart.add_theme_color_override("font_color", Color.WHITE)
	$VBoxContainer/Setting.add_theme_color_override("font_color", Color.WHITE)
	$VBoxContainer/Title.add_theme_color_override("font_color", Color.WHITE)

func _select(index : int):
	match index:
		0:
			__initiateSelectColor()
			$VBoxContainer/Resume.add_theme_color_override("font_color", Gvar.ACCENT_COLOR)
		1:
			__initiateSelectColor()
			$VBoxContainer/Restart.add_theme_color_override("font_color", Gvar.ACCENT_COLOR)
		2:
			__initiateSelectColor()
			$VBoxContainer/Setting.add_theme_color_override("font_color", Gvar.ACCENT_COLOR)
		3:
			__initiateSelectColor()
			$VBoxContainer/Title.add_theme_color_override("font_color", Gvar.ACCENT_COLOR)
		
@onready var switchStream = load("res://se/switch.mp3")
func play_sound():
	$AudioStreamPlayer2D.stop()
	$AudioStreamPlayer2D.stream = switchStream
	$AudioStreamPlayer2D.play()		

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	
	currentIndex = 0
	_select(currentIndex)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visibility_changed():
	currentIndex = 0
	_select(currentIndex)
	pass # Replace with function body.
