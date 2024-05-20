extends Node2D

@onready var anim = $Anim

var isDamagedInvincible = false
var isGoalApproachingInvincible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.speed_scale = 4
	anim.play("stand")
	
	$Camera2D.limit_bottom = Gvar.CameraLimitBottom
	
	pass # Replace with function body.

func Initialize():
	position.y = -33
	Gvar.PlayerPosition = position
	$InvincibleTimer.wait_time = Gvar.INVINCIBLE_TIME
	$Camera2D.limit_bottom = Gvar.CameraLimitBottom
	$Camera2D.reset_smoothing()
	$Camera2D/ShakeTween.Initialize()
	
func OnGetDamaged() -> bool:
	var result : bool = false
	if(isDamagedInvincible == false and isGoalApproachingInvincible == false):
		if Gvar.HP > 0: 
			Gvar.HP -= 1
		$Camera2D/ShakeTween.SetCameraShakeTime(Gvar.CAMERA_SHAKE_TIME)
		isDamagedInvincible = true
		$InvincibleTimer.start()
		
		result = true
	
	if(Gvar.HP == 0 and Gvar.Gamemode == Gvar.GamemodeEnum.Play):
		get_parent().SetGamemodeGameover()
		
	return result

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Gvar.PlayerPosition = position
	
	if Gvar.IsWalking:
		anim.play("walk")
		position.y += Gvar.WALK_SPEED * delta
		Gvar.Distance += Gvar.WALK_SPEED * delta
	else:
		anim.play("stand")
		
	
	if(Gvar.Distance > Gvar.CameraLimitBottom):
		isGoalApproachingInvincible = true
	else:
		isGoalApproachingInvincible = false
	pass


func _on_invincible_timer_timeout():
	isDamagedInvincible = false
	pass # Replace with function body.
