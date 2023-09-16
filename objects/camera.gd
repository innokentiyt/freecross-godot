extends Node3D

const HALF_PI = PI/2

var mouse_h_sensitivity := 0.0015
var mouse_v_sensitivity := 0.002
var horizontal_input := 0.0
var vertical_input := 0.0

@onready var h := self
@onready var v := get_node("camera_vertical_pivot") as Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	h.rotate_y(horizontal_input)
	v.rotate_x(vertical_input)
	v.rotation.x = clamp(v.rotation.x, -HALF_PI, HALF_PI)
	horizontal_input = 0.0
	vertical_input = 0.0

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton:
		if Input.is_action_pressed("middle_mouse_button"):
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CONFINED_HIDDEN:
		if event is InputEventMouseMotion:
			horizontal_input = -event.relative.x * mouse_h_sensitivity
			vertical_input = -event.relative.y * mouse_v_sensitivity
