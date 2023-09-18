@tool
class_name Block
extends CSGBox3D

const materials = {
	"TW": preload("res://materials/transparent_white.tres"),
	"DG": preload("res://materials/dark_greenish.tres")
}

@export var filled: bool = false:
	set(new):
		filled = new
		if new:
			material = materials["DG"]
		else:
			material = materials["DG"]

@export var x: float = 0:
	set(new):
		x = new
		position.x = new

@export var y: float = 0:
	set(new):
		y = new
		position.y = new

@export var z: float = 0:
	set(new):
		z = new
		position.z = new

var sums: Vector3i = Vector3i(9, 9, 9)


# class constructor
func set_attributes(xyz: Vector3, set_filled: bool, set_sums: Vector3i):
	rotation = Vector3.ZERO
	x = xyz.x
	y = xyz.y
	z = xyz.z
	sums = set_sums
	$dice_digits.set_sums(set_sums)
	filled = set_filled


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_3d_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if Input.is_action_pressed("left_mouse_button"):
			if not filled:
				get_parent().empty_blocks_count -= 1
				self.queue_free()
