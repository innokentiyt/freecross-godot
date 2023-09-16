@tool
extends CSGBox3D

class_name Block

const materials = {
	"TW": preload("res://materials/transparent_white.tres"),
	"DG": preload("res://materials/dark_greenish.tres")
}

@export var filled: bool = false:
	set(new):
		filled = new
		print("new filled: " + str(new))
		if new:
			material = materials["DG"]
		else:
			material = materials["TW"]

@export var x: float = 0:
	set(new):
		x = new
		print("new x: " + str(new))
		position.x = new
@export var y: float = 0:
	set(new):
		y = new
		print("new y: " + str(new))
		position.y = new
@export var z: float = 0:
	set(new):
		z = new
		print("new z: " + str(new))
		position.z = new

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = Vector3.ZERO
	position.x = self.x
	position.y = self.y
	position.z = self.z
	if filled:
		material = materials["DG"]
	else:
		material = materials["TW"]
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
