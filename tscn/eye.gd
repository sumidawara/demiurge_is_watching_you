extends Node2D

@onready var animatedSprite = $AnimatedSprite2D
@onready var explosionEffect = load("res://tscn/explosion_particle.tscn")

enum AnimeEnum{
	wait,
	_0to7,
	_7to0
}

var animeArray : Array[AnimeEnum]
var plannedFinalState : int
var detectArea : CollisionShape2D

func weightedRandom(_weightArray : Array[int]) -> int :
	var sum = 0
	for item in _weightArray:
		sum += item

	var roll = randi_range(0, sum)
	var front = 0
	var back = 0
	for i in _weightArray.size():
		back += _weightArray[i]
		if(front <= roll and roll < back):
			return i
		front = back
	return -1

func planAnime():
	while (animeArray.size() < 5):
		if animeArray.size() == 0:
			animeArray.push_back(AnimeEnum._0to7)
			plannedFinalState = 7
		else:
			match plannedFinalState:
				7:
					match weightedRandom([50, 10]):
						0:
							animeArray.push_back(AnimeEnum._7to0)
							plannedFinalState = 0
						1:
							animeArray.push_back(AnimeEnum.wait)
							plannedFinalState = plannedFinalState
				0:
					match weightedRandom([10, 50]):
						0:
							animeArray.push_back(AnimeEnum._0to7)
							plannedFinalState = 7
						1:
							animeArray.push_back(AnimeEnum.wait)
							plannedFinalState = plannedFinalState
					
func playAnime():
	var nextAnime = animeArray.pop_front()
	match nextAnime:
		AnimeEnum.wait:
			var timer = $Timer
			timer.start()
		AnimeEnum._0to7:
			animatedSprite.play("0to7")
		AnimeEnum._7to0:
			animatedSprite.play("7to0")	

@onready var stream1 = load("res://se/attack1.mp3")
@onready var stream2 = load("res://se/attack2.mp3")
@onready var stream3 = load("res://se/attack3.mp3")
@onready var stream4 = load("res://se/attack4.mp3")
func play_sound():
	#$AudioStreamPlayer2D.stop()
	var rand : int = randi_range(0, 4)
	match(rand):
		0:
			$AudioStreamPlayer2D.stream = stream1
		1:
			$AudioStreamPlayer2D.stream = stream2
		2:
			$AudioStreamPlayer2D.stream = stream3
		3:
			$AudioStreamPlayer2D.stream = stream4
	$AudioStreamPlayer2D.play()

func _ready():	
	detectArea = $"../InitialSpawnRegion"
	
	planAnime()
	playAnime()
	pass # Replace with function body.

func _detectFullOpen() -> bool:
	var detectAreaSize = detectArea.shape.size
	var detectAreaPosition = detectArea.position - Vector2(detectArea.shape.size.x / 2, detectArea.shape.size.y / 2)
	
	if animatedSprite.animation == "0to7" and animatedSprite.frame == 7:
		if(detectAreaPosition.x < position.x and position.x < detectAreaPosition.x + detectAreaSize.x):
			if(detectAreaPosition.y < position.y and position.y < detectAreaPosition.y + detectAreaSize.y):
				return true
		return false
	elif animatedSprite.animation == "7to0" and animatedSprite.frame == 0:
		if(detectAreaPosition.x < position.x and position.x < detectAreaPosition.x + detectAreaSize.x):
			if(detectAreaPosition.y < position.y and position.y < detectAreaPosition.y + detectAreaSize.y):
				return true
		return false
	else:
		return false

func _process(delta):
	#被弾時の処理
	if _detectFullOpen() and Gvar.IsWalking == true:
		var player = get_parent().get_parent().get_node("Player")
		var isDamaged = player.OnGetDamaged()
		
		if isDamaged:			
			play_sound()
			var effect = explosionEffect.instantiate()
			add_child(effect)
		
	
	if position.y < Gvar.DeleteRegionY:
		queue_free()
	#animeの計画
	planAnime()
	pass

#もし止まってたらanimeを実行
func _on_animated_sprite_2d_animation_finished():
	playAnime()
	pass # Replace with function body.


func _on_timer_timeout():
	playAnime()
	pass # Replace with function body.
