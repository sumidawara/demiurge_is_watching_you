extends Node2D

func SetGamemodeGameover():
	Gvar.PreviousGamemode = Gvar.Gamemode
	Gvar.Gamemode = Gvar.GamemodeEnum.Gameover
	Engine.time_scale = 0
	$Gameover.visible = true
	$Menu.visible = false
	$Setting.visible = false
	$Title.visible = false
	$Dialogue.visible = false

func _setGamemodePlay():
	Gvar.PreviousGamemode = Gvar.Gamemode
	Gvar.Gamemode = Gvar.GamemodeEnum.Play
	Engine.time_scale = 1
	$UI.visible = true
	$Menu.visible = false
	$Setting.visible = false
	$Gameover.visible = false
	$Title.visible = false
	$Dialogue.visible = false

func _setGamemodeMenu():
	Gvar.PreviousGamemode = Gvar.Gamemode
	Gvar.Gamemode = Gvar.GamemodeEnum.Menu
	Engine.time_scale = 0
	$Menu.visible = true
	$Setting.visible = false
	$Gameover.visible = false
	$Title.visible = false
	$Dialogue.visible = false

func _setGamemodeSetting():
	Gvar.PreviousGamemode = Gvar.Gamemode
	Gvar.Gamemode = Gvar.GamemodeEnum.Setting
	$Setting.visible = true
	if(Gvar.PreviousGamemode == Gvar.GamemodeEnum.Title):
		$Setting.BackgroundVisible(true)
	else:
		$Setting.BackgroundVisible(false)
	$Menu.visible = false
	$Gameover.visible = false
	$Title.visible = false
	$Dialogue.visible = false

func _setGamemodeTitle():
	Gvar.PreviousGamemode = Gvar.Gamemode 
	Gvar.Gamemode = Gvar.GamemodeEnum.Title
	$EyeSummoner.DeleteAllEye()
	Engine.time_scale = 0
	$Title.visible = true
	$UI.visible = false
	$Setting.visible = false
	$Menu.visible = false
	$Gameover.visible = false
	$Dialogue.visible = false

func _setGamemodeDialogue():
	Gvar.PreviousGamemode = Gvar.Gamemode 
	Gvar.Gamemode = Gvar.GamemodeEnum.Dialogue
	Engine.time_scale = 1
	$Dialogue.visible = true
	$Title.visible = false
	$UI.visible = false
	$Setting.visible = false
	$Menu.visible = false
	$Gameover.visible = false		

func Play():
	if(Gvar.Gamemode == Gvar.GamemodeEnum.Title and Gvar.IsEndlessModeOn == false):
		_setGamemodeDialogue()
		$Dialogue.Start(Gvar.DialogueEnum.Prologue)
	else:
		_initialize()
		_setGamemodePlay()

func Resume():
	_setGamemodePlay()
	pass
	
func _initialize():
	Gvar.Distance = 0
	Gvar.HP = Gvar.MAX_HP
	$EyeSummoner.DeleteAllEye()
	$EyeSummoner.Initialization()
	$Player.Initialize()	
	$Background.Initialize()
func Restart():
	_initialize()
	_setGamemodePlay()
	pass

func Setting():
	_setGamemodeSetting()
	pass

func Title():
	_setGamemodeTitle()
	pass

func Epilogue():
	_setGamemodeDialogue()
	$Dialogue.Start(Gvar.DialogueEnum.Epilogue)
	

func Setting_BGM():
	if(Gvar.IsBGMOn):
		Gvar.IsBGMOn = false
	else:
		Gvar.IsBGMOn = true
	pass

func Setting_SE():
	if(Gvar.IsSEOn):
		Gvar.IsSEOn = false
	else:
		Gvar.IsSEOn = true
	pass

func Setting_Gamemode():
	if(Gvar.IsEndlessModeOn and Gvar.IsStorymodeCleared):
		Gvar.IsEndlessModeOn = false
	elif(Gvar.IsEndlessModeOn == false and Gvar.IsStorymodeCleared):
		Gvar.IsEndlessModeOn = true
	pass

func Setting_Back():
	if Gvar.PreviousGamemode == Gvar.GamemodeEnum.Menu:
		_setGamemodeMenu()
	elif Gvar.PreviousGamemode == Gvar.GamemodeEnum.Title:
		_setGamemodeTitle()
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	_setGamemodeTitle()
	pass # Replace with function body.

func _input(event):
	match Gvar.Gamemode:
		Gvar.GamemodeEnum.Play:
			if event.is_action_pressed("space"):
				Gvar.IsWalking = true
			elif event.is_action_released("space"):
				Gvar.IsWalking = false
			elif event.is_action_pressed("esc"):
				_setGamemodeMenu()
		Gvar.GamemodeEnum.Menu:
			if event.is_action_pressed("up"):
				$Menu.Select(-1)
			elif event.is_action_pressed("down"):
				$Menu.Select(1)
			elif event.is_action_pressed("space"):
				$Menu.Select(0)
			elif event.is_action_pressed("esc"):
				_setGamemodePlay()
		Gvar.GamemodeEnum.Setting:
			if event.is_action_pressed("up"):
				$Setting.Select(-1)
			elif event.is_action_pressed("down"):
				$Setting.Select(1)
			elif event.is_action_pressed("space"):
				$Setting.Select(0)
			elif event.is_action_pressed("esc"):
				_setGamemodeMenu()
		Gvar.GamemodeEnum.Gameover:
			if event.is_action_pressed("up"):
				$Gameover.Select(-1)
			elif event.is_action_pressed("down"):
				$Gameover.Select(1)
			elif event.is_action_pressed("space"):
				$Gameover.Select(0)
			elif event.is_action_pressed("esc"):
				_setGamemodeMenu()
		Gvar.GamemodeEnum.Title:
			if event.is_action_pressed("up"):
				$Title.Select(-1)
			elif event.is_action_pressed("down"):
				$Title.Select(1)
			elif event.is_action_pressed("space"):
				$Title.Select(0)
		Gvar.GamemodeEnum.Dialogue:
			pass
				
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Gvar.Gamemode == Gvar.GamemodeEnum.Play and Gvar.Distance > Gvar.GoalDistance and Gvar.IsEndlessModeOn == false):
		Epilogue()
		Gvar.IsStorymodeCleared = true
	
	pass
