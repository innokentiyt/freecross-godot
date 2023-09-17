@tool
class_name CameraScene
extends Node3D

const HALF_PI := PI/2
const mouse_h_sensitivity := 0.0035
const mouse_v_sensitivity := 0.004
const distance_multiplier = 1.1

var horizontal_input := 0.0
var vertical_input := 0.0

@onready var h := self
@onready var v := get_node("camera_vertical_pivot") as Node3D
@onready var distanced_camera := get_node("camera_vertical_pivot/Camera3D") as Camera3D

@export var distance: float
@export var observing_shape_size: Vector3i


func get_distance(shape_size: Vector3) -> float:
	var diagonal_length = sqrt(
		pow(shape_size.x, 2) +
		pow(shape_size.y, 2) +
		pow(shape_size.z, 2)
	)
	return diagonal_length * distance_multiplier


func set_attributes(shape_size: Vector3i):
	observing_shape_size = shape_size
	distance = get_distance(shape_size)
	distanced_camera.position.z = distance


# Called when the node enters the scene tree for the first time.
func _ready():
	print("camera ready")
	distanced_camera.position.z = distance
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	h.rotate_y(horizontal_input)
	v.rotate_x(vertical_input)
	v.rotation.x = clamp(v.rotation.x, -HALF_PI, HALF_PI)
	horizontal_input = 0.0
	vertical_input = 0.0


func _unhandled_input(event: InputEvent):
	if (event is InputEventMouseButton) or (event is InputEventKey):
		if Input.is_action_pressed("hold_to_move"):
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CONFINED_HIDDEN:
		if event is InputEventMouseMotion:
			horizontal_input = -event.relative.x * mouse_h_sensitivity
			vertical_input = -event.relative.y * mouse_v_sensitivity
