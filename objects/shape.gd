class_name Shape
extends Node3D

enum Axis { X_AXIS, Y_AXIS, Z_AXIS }

var size: Vector3i
var blocks: Array[Block] = []
var empty_blocks_count := 0
var y_mirrored_3d_array: Array

var block_scene: PackedScene = preload("res://scenes/block.tscn")

# class constructor
func _init(dict: Dictionary):
	size.x = dict["x"]
	size.y = dict["y"]
	size.z = dict["z"]
	print("width: " + str(size.x) + ", height: " + str(size.y) + ", depth: " + str(size.z))
	var initial_brush_position = Vector3(
		-(size.x - 1.0)/2.0,
		-(size.y - 1.0)/2.0,
		-(size.z - 1.0)/2.0
	)
	var brush_position = initial_brush_position
	print("initial brush_position: " + str(brush_position))
	y_mirrored_3d_array = y_mirror_3d_array(dict["layers"])
	
	var z_sum = sum_axis_3d_array_to_2d_array(y_mirrored_3d_array, Axis.Z_AXIS)
	print("z_sum: " + str(z_sum))
	var y_sum = sum_axis_3d_array_to_2d_array(y_mirrored_3d_array, Axis.Y_AXIS)
	print("y_sum: " + str(y_sum))
	var x_sum = sum_axis_3d_array_to_2d_array(y_mirrored_3d_array, Axis.X_AXIS)
	print("x_sum: " + str(x_sum))
	
	for layer_i in len(y_mirrored_3d_array): # z_i
		for line_i in len(y_mirrored_3d_array[layer_i]): # y_i
			for dot_i in len(y_mirrored_3d_array[layer_i][line_i]): # x_i
				var dot = y_mirrored_3d_array[layer_i][line_i][dot_i]
				var filled = dot > 0
				if not filled:
					empty_blocks_count += 1
				# print("dot=" + str(dot) + ", filled=" + str(filled))
				var block_instance := block_scene.instantiate() as Block
				block_instance.set_attributes(
					Vector3(brush_position.x, brush_position.y, brush_position.z),
					filled,
					Vector3(
						x_sum[line_i][layer_i],
						y_sum[layer_i][dot_i],
						z_sum[line_i][dot_i]
					)
				)
				blocks.append(block_instance)
				brush_position.x += 1.0
			brush_position.x = initial_brush_position.x
			brush_position.y += 1.0
		brush_position.y = initial_brush_position.y
		brush_position.z += 1.0
	print("shape initialized")

func y_mirror_3d_array(array) -> Array:
	var result_array = []
	result_array.resize(size.z)
	for z in size.z:
		result_array[z] = []
		result_array[z].resize(size.y)
		for y in size.y:
			result_array[z][y] = array[z][size.y - 1 - y]
	return result_array

func sum_axis_3d_array_to_2d_array(array, axis: Axis) -> Array:
	var lines: int
	var columns: int
	match axis:
		Axis.X_AXIS:
			lines = size.y
			columns = size.z
		Axis.Y_AXIS:
			lines = size.z
			columns = size.x
		Axis.Z_AXIS:
			lines = size.y
			columns = size.x
	var result_array = create_2d_array(lines, columns, 0)
	for layer_i in len(array): # z_i
		for line_i in len(array[layer_i]): # y_i
			for dot_i in len(array[layer_i][line_i]): # x_i
				var dot = array[layer_i][line_i][dot_i]
				var dot_filled = dot > 0
				if dot_filled:
					var i: int
					var j: int
					match axis:
						Axis.X_AXIS:
							i = line_i # y
							j = layer_i # z
						Axis.Y_AXIS:
							i = layer_i # z
							j = dot_i # x
						Axis.Z_AXIS:
							i = line_i # y
							j = dot_i # x
					result_array[i][j] += 1
	return result_array

func create_2d_array(lines: int, columns: int, value = null) -> Array:
	var result_array = []
	result_array.resize(lines)
	for line_i in lines:
		result_array[line_i] = []
		result_array[line_i].resize(columns)
		result_array[line_i].fill(value)
	return result_array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
