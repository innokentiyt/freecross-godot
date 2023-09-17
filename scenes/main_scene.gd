@tool
extends Node3D

const shapes_order: Array[String] = ["simple_pyramid"]

@onready var current_shape_name: String = shapes_order.pick_random()
@onready var assembled := get_node("assembled") as Assembled
@onready var camera := get_node("camera") as CameraScene

# Called when the node enters the scene tree for the first time.
func _ready():
	print("MainScene ready")
	assembled.shape_name = current_shape_name
	camera.set_attributes(assembled.shape.size)
	# print_tree_pretty()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
