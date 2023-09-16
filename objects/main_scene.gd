@tool
extends Node3D

const shapes_order: Array[String] = ["simple_pyramid"]
var current_shape_name: String

# Called when the node enters the scene tree for the first time.
func _ready():
	current_shape_name = shapes_order.pick_random()
	var assembled = get_node("assembled") as Assembled
	assembled.shape_name = current_shape_name
	var current_shape_dict = load_shape_json(current_shape_name)
	var camera = get_node("camera_horizontal_pivot/camera_vertical_pivot/distanced_camera") as DistancedCamera
	camera.observing_shape_size = Vector3(
		current_shape_dict["x"],
		current_shape_dict["y"],
		current_shape_dict["z"]
	)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func load_shape_json(file_name: String) -> Dictionary:
	var path = "res://shapes/" + file_name + ".json"
	print("path: " + path)
	var file = FileAccess.open(path, FileAccess.READ)
	var text_content = file.get_as_text()
	var dict = JSON.parse_string(text_content)
	return dict


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
