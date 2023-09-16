@tool
extends Camera3D

class_name DistancedCamera

@export var observing_shape_size: Vector3 = Vector3(1, 1, 1):
	set(new):
		print("setting new observing_shape_size: " + str(new))
		observing_shape_size = new
		distance = get_distance(new)

var distance: float:
	set(new):
		print("setting new distance: " + str(new))
		position.z = new

const distance_multiplier = 1.2

# Called when the node enters the scene tree for the first time.
func _ready():
	distance = get_distance(observing_shape_size)


func get_distance(shape_size: Vector3) -> float:
	var diagonal_length = sqrt(
		pow(shape_size.x, 2) +
		pow(shape_size.y, 2) +
		pow(shape_size.z, 2)
	)
	return diagonal_length * distance_multiplier

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
