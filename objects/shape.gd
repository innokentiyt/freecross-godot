class_name Shape
extends Node

var size: Vector3i
var blocks: Array[Block] = []
var empty_blocks_count := 0

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
	for layer in dict["layers"]: # z
		for line in layer: # y
			for dot in line: # x
				var filled = dot > 0
				if not filled:
					empty_blocks_count += 1
				print("dot=" + str(dot) + ", filled=" + str(filled))
				var block = Block.new()
				block.filled = filled
				block.x = brush_position.x
				block.y = brush_position.y
				block.z = brush_position.z
				blocks.append(block)
				brush_position.x += 1.0
			brush_position.x = initial_brush_position.x
			brush_position.y += 1.0
		brush_position.y = initial_brush_position.y
		brush_position.z += 1.0
	print("empty blocks count: " + str(empty_blocks_count))
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
