@tool
class_name FacePair
extends Node3D

var crop_region: Rect2:
	set(new):
		crop_region = new
		var children = get_children().filter(func(child): return child is Sprite3D)
		for child in children:
			child.region_enabled = true
			child.region_rect = new

var pixel_size: float:
	set(new):
		pixel_size = new
		var children = get_children().filter(func(child): return child is Sprite3D)
		for child in children:
			child.pixel_size = new

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
