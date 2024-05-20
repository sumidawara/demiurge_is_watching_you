extends Node

const Eye = preload("res://tscn/eye.tscn")

var initialSpawnRegionSize : Vector2
var initialSpawnRegionPosition : Vector2
var spawnRegionSize : Vector2
var spawnRegionPosition : Vector2

func SummonEye(_x : int, _y : int):
	var eye = Eye.instantiate()
	eye.position = Vector2(_x, _y)
	add_child(eye)

func Distance2EyeCount(_distance : float):
	var _eyeCount = floor((100 *_distance) /(10000 - _distance)) + 1
	return _eyeCount
	
func Initialization():
	$InitialSpawnRegion.position.y = 0.5
	$DeleteRegion.position.y = -77
	$SpawnRegion.position.y = 115
	
	initialSpawnRegionSize = $InitialSpawnRegion.shape.size
	initialSpawnRegionPosition = $InitialSpawnRegion.position - Vector2($InitialSpawnRegion.shape.size.x / 2, $InitialSpawnRegion.shape.size.y / 2)
	Gvar.DeleteRegionY = $DeleteRegion.position.y
	
	for i in Distance2EyeCount(Gvar.Distance):
		var x = initialSpawnRegionPosition.x + randi_range(0, initialSpawnRegionSize.x)
		var y = initialSpawnRegionPosition.y + randi_range(0, initialSpawnRegionSize.y)
		SummonEye(x, y)	

func DeleteAllEye():
	for c in get_children():
		#RegionはCollisionShpe2DなのでEyeオブジェクトと識別可能
		if(c.get_class() == "Node2D"):
			c.queue_free()

func _ready():
	Initialization()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#カメラ座標に追従させる
	if Gvar.IsWalking:
		$InitialSpawnRegion.position.y += Gvar.WALK_SPEED * delta
		$SpawnRegion.position.y += Gvar.WALK_SPEED * delta
		$DeleteRegion.position.y += Gvar.WALK_SPEED * delta
	#Region関係の変数の更新
	spawnRegionSize = $SpawnRegion.shape.size
	spawnRegionPosition = $SpawnRegion.position - Vector2($SpawnRegion.shape.size.x / 2, $SpawnRegion.shape.size.y / 2)
	Gvar.DeleteRegionY = $DeleteRegion.position.y
	
	var currentEyeCount = get_children().size() - 3
	
	#目玉の数の制御
	var idealEyeCount = Distance2EyeCount(Gvar.Distance)
	if(currentEyeCount < idealEyeCount):
		var x = spawnRegionPosition.x + randi_range(0, spawnRegionSize.x)
		var y = spawnRegionPosition.y + randi_range(0, spawnRegionSize.y)
		SummonEye(x, y)
	
	pass
