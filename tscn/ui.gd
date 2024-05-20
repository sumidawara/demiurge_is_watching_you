extends CanvasLayer

@onready var heartContainer : Node = $HeartContainer
@onready var heartTexture = load("res://img/UI/heart.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	setHeart(Gvar.HP)
	pass # Replace with function body.

func removeHeart():
	if(heartContainer.get_child_count() != 0):
		heartContainer.get_children()[heartContainer.get_child_count() - 1].queue_free()
	

func addHeart():
	var heart = TextureRect.new()
	heart.texture = heartTexture
	heartContainer.add_child(heart)
	
func setHeart(_hp : int):
	var dif = _hp - heartContainer.get_child_count()
	if(dif > 0):
		for i in dif:
			addHeart()
	elif(dif < 0):
		for i in abs(dif):
			removeHeart()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$LabelDistance.text = str(floor(Gvar.Distance)) + "km"
	setHeart(Gvar.HP)
	pass
