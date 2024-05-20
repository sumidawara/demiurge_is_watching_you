extends  Node2D

enum GamemodeEnum
{
	Play,
	Menu,
	Setting,
	Title,
	Gameover,
	Dialogue
}

enum DialogueEnum
{
	Prologue,
	Epilogue
}

const INVINCIBLE_TIME : float = 2.0
const CAMERA_SHAKE_TIME : float = 2.0
const WALK_SPEED : float = 40
const ACCENT_COLOR : String = "#FF0084"
const ACCENT_DIM_COLOR : String = "#850045"

const MAX_HP = 5

const _CAMERA_LIMIT_BOTTOM_STORY = 800
const _CAMERA_LIMIT_BOTTOM_ENDLESS = 8888
const _GOAL_DISTANCE_OFFCET = 60
var CameraLimitBottom = _CAMERA_LIMIT_BOTTOM_STORY
var GoalDistance : float = CameraLimitBottom + _GOAL_DISTANCE_OFFCET


var Gamemode : GamemodeEnum
var PreviousGamemode : GamemodeEnum
var Distance : float = 0
var PlayerPosition : Vector2
var IsWalking : bool = false
var HP : int = MAX_HP
var DeleteRegionY : float

var IsBGMOn = true
var IsSEOn = true
#var IsPrologueOn = true
#var IsEpilogueOn = true

var IsStorymodeCleared = false
var IsEndlessModeOn : bool = false :
	set(value):
		if value == true:
			CameraLimitBottom = _CAMERA_LIMIT_BOTTOM_ENDLESS
		else:
			CameraLimitBottom = _CAMERA_LIMIT_BOTTOM_STORY
		IsEndlessModeOn = value
	get:
		return IsEndlessModeOn

var IsDebugDialogueText= false

signal DialogueBackgroundIndex_Changed
var DialogueBackgroundIndex : int :
	set(value):
		DialogueBackgroundIndex = value
		DialogueBackgroundIndex_Changed.emit()
	get:
		return DialogueBackgroundIndex
