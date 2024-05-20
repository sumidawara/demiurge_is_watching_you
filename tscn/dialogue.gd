extends CanvasLayer

@onready var mainScript = load("res://dialogue/main.dialogue")
@onready var debugScript = load("res://dialogue/debug.dialogue")
@onready var dialogueScript = load("res://dialogue/dialogue.dialogue")
@onready var Balloon = load("res://tscn/balloon.tscn")

@onready var bg1 = load("res://img/background/1.png")
@onready var bg2 = load("res://img/background/2.png")
@onready var bg3 = load("res://img/background/3.png")
@onready var bg4 = load("res://img/background/4.png")
@onready var bg5 = load("res://img/background/5.png")
@onready var bg6 = load("res://img/background/6.png")
@onready var bg7 = load("res://img/background/7.png")
@onready var bg8 = load("res://img/background/8.png")
@onready var bg9 = load("res://img/background/9.png")
@onready var bg10 = load("res://img/background/10.png")

var currentPoint : Gvar.DialogueEnum

func Start(_startPoint : Gvar.DialogueEnum):
	var balloon = Balloon.instantiate()
	add_child(balloon)
	currentPoint = _startPoint
	
	if(_startPoint == Gvar.DialogueEnum.Prologue):
		if(Gvar.IsDebugDialogueText):
			balloon.start(debugScript, "Prologue")
		else:
			balloon.start(mainScript, "Prologue")
	elif(_startPoint == Gvar.DialogueEnum.Epilogue):
		if(Gvar.IsDebugDialogueText):
			balloon.start(debugScript, "Epilogue")
		else:
			balloon.start(mainScript, "Epilogue")
	pass

#Dialogue Manager用
func OnDialogueFinished():
	if(currentPoint == Gvar.DialogueEnum.Prologue):
		get_parent().Play()
	elif(currentPoint == Gvar.DialogueEnum.Epilogue):
		get_parent().Title()
	pass
	
func On_DialogueBackgroundIndex_Changed():
	match (Gvar.DialogueBackgroundIndex):
		1:
			$Image.texture = bg1
		2:
			$Image.texture = bg2
		3:
			$Image.texture = bg3
		4:
			$Image.texture = bg4
		5:
			$Image.texture = bg5
		6:
			$Image.texture = bg6
		7:
			$Image.texture = bg7
		8:
			$Image.texture = bg8
		9:
			$Image.texture = bg9
		10:
			$Image.texture = bg10
	pass

	
# Called when the node enters the scene tree for the first time.
func _ready():
	Gvar.DialogueBackgroundIndex_Changed.connect(On_DialogueBackgroundIndex_Changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
