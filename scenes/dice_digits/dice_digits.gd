@tool
class_name DiceDigits
extends Node3D

const colors = {
	true: Color("008074"),
	false : Color.WHITE
}

@export var texture: Texture2D
var sums := Vector3i(1, 2, 3)
@export var filled := false

var crop_region_x = get_crop_region(sums.x)
var crop_region_y = get_crop_region(sums.y)
var crop_region_z = get_crop_region(sums.z)

@onready var texture_width := texture.get_width()
@onready var texture_height := texture.get_height()
@onready var region_width := texture_width / 10.0
@onready var region_height := texture_height
@onready var pixel_size := 1.0 / region_width

# Called when the node enters the scene tree for the first time.
func _ready():
	set_props(sums, filled)


func set_props(new_sums: Vector3i, new_filled: bool):
	sums = new_sums
	filled = new_filled
	
	var colorRect = get_node("digits_viewport/ColorRect") as ColorRect
	colorRect.color = colors[false]
	
	crop_region_x = get_crop_region(new_sums.x)
	crop_region_y = get_crop_region(new_sums.y)
	crop_region_z = get_crop_region(new_sums.z)
	
	$x_faces.crop_region = crop_region_x
	$y_faces.crop_region = crop_region_y
	$z_faces.crop_region = crop_region_z
	
	$x_faces.pixel_size = pixel_size
	$y_faces.pixel_size = pixel_size
	$z_faces.pixel_size = pixel_size
	

func set_colored(new_colored: bool):
	var colorRect = get_node("digits_viewport/ColorRect") as ColorRect
	colorRect.color = colors[filled]


func get_crop_region(digit: int) -> Rect2i:
	var x = region_width * digit
	var y = 0
	var w = region_width
	var h = region_height
	return Rect2(x, y, w, h)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
