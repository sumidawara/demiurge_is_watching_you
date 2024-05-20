extends Node

@onready var road1 = $Road1
@onready var road2 = $Road2

const yOffset = 384 * 2
const diff = 250

func Initialize():
	road1.position.y = 16
	road2.position.y = 400
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Gvar.PlayerPosition.y - road1.position.y > diff):
		road1.position.y += yOffset
	
	if(Gvar.PlayerPosition.y - road2.position.y > diff):
		road2.position.y += yOffset	
	pass
