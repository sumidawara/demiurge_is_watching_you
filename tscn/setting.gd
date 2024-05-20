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
				parent.Setting_BGM()
				if(Gvar.IsBGMOn == true):
					$VBoxContainer/BGM.text = "BGM        on"
				else:
					$VBoxContainer/BGM.text = "BGM        off"
			1:
				parent.Setting_SE()				
				if(Gvar.IsSEOn == true):
					$VBoxContainer/SE.text = "SE         on"
				else:
					$VBoxContainer/SE.text = "SE         off"
			2:
				parent.Setting_Gamemode()				
				if(Gvar.IsEndlessModeOn == true):
					$VBoxContainer/Gamemode.text = "Gamemode   Endless"
				else:
					$VBoxContainer/Gamemode.text = "Gamemode   Story"
			3:
				parent.Setting_Back()

func BackgroundVisible(_bool : bool):
	$Background.visible = _bool
				
		

func __initiateSelectColor():
	$VBoxContainer/BGM.add_theme_color_override("font_color", Color.WHITE)
	$VBoxContainer/SE.add_theme_color_override("font_color", Color.WHITE)
	$VBoxContainer/Back.add_theme_color_override("font_color", Color.WHITE)
	
	if(Gvar.IsStorymodeCleared):
		$VBoxContainer/Gamemode.add_theme_color_override("font_color", Color.WHITE)
	else:
		$VBoxContainer/Gamemode.add_theme_color_override("font_color", Color.DIM_GRAY)

func _select(index : int):
	match index:
		0:
			__initiateSelectColor()
			$VBoxContainer/BGM.add_theme_color_override("font_color", Gvar.ACCENT_COLOR)
		1:
			__initiateSelectColor()
			$VBoxContainer/SE.add_theme_color_override("font_color", Gvar.ACCENT_COLOR)
		2:
			__initiateSelectColor()
			if(Gvar.IsStorymodeCleared):
				$VBoxContainer/Gamemode.add_theme_color_override("font_color", Gvar.ACCENT_COLOR)
			else:
				$VBoxContainer/Gamemode.add_theme_color_override("font_color", Gvar.ACCENT_DIM_COLOR)
		3:
			__initiateSelectColor()
			$VBoxContainer/Back.add_theme_color_override("font_color", Gvar.ACCENT_COLOR)

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
