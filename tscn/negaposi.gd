extends ColorRect

var center_pos = Vector2(0.5, 0.5)
@export var inside_radius : float = 0.1
@export var outside_radius : float = 0.8
var display_ratio : float = 0.58

#@onready var shader :ShaderMaterial = $MeshInstance.get_active_material(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	material.set_shader_parameter("center_pos", center_pos)
	material.set_shader_parameter("inside_radius", inside_radius)
	material.set_shader_parameter("outside_radius", outside_radius)
	material.set_shader_parameter("display_ratio", display_ratio)
	pass
