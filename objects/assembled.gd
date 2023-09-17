@tool
class_name Assembled
extends Node3D

@export var shape_name: String = "simple_pyramid":
	set(new):
		shape_name = new
		shape = load_shape(shape_name)
		assemble()

var shape: Shape

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.is_editor_hint():
		shape = load_shape(shape_name)
		assemble()


func load_shape(file_name: String) -> Shape:
	var path = "res://shapes/" + file_name + ".json"
	print("path: " + path)
	var file = FileAccess.open(path, FileAccess.READ)
	var text_content = file.get_as_text()
	var dict = JSON.parse_string(text_content)
	return Shape.new(dict)


func assemble():
	for child in self.get_children():
		child.queue_free()
	for block in shape.blocks:
		self.add_child(block)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
