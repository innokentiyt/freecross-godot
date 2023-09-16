@tool
extends Node3D

class_name Assembled

@export var shape_name: String = "simple_pyramid":
	set(new):
		shape_name = new
		var shape_dict = load_shape_json(shape_name)
		assemble(shape_dict)

var empty_blocks_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.is_editor_hint():
		var shape_dict = load_shape_json(shape_name)
		assemble(shape_dict)


func load_shape_json(file_name: String) -> Dictionary:
	var path = "res://shapes/" + file_name + ".json"
	print("path: " + path)
	var file = FileAccess.open(path, FileAccess.READ)
	var text_content = file.get_as_text()
	var dict = JSON.parse_string(text_content)
	return dict


func assemble(dict: Dictionary):
	var width = dict["x"]
	var height = dict["y"]
	var depth = dict["z"]
	print(self.position)
	var initial_brush_position = Vector3(
		-(width - 1)/2,
		-(height - 1)/2,
		-(depth - 1)/2
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
				self.add_child(block)
				brush_position.x += 1.0
			brush_position.x = initial_brush_position.x
			brush_position.y += 1.0
		brush_position.y = initial_brush_position.y
		brush_position.z += 1.0
	print("empty blocks count: " + str(empty_blocks_count))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
