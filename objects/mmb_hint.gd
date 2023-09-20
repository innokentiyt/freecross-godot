extends Label

var visibility_seconds := 6.0
var fade_out_seconds := 1.5
var remove_after_seconds := visibility_seconds + fade_out_seconds
var timer := 0.0

@onready var original_color := self.modulate
@onready var original_alpha := original_color.a
@onready var alpha_loss_speed := original_alpha / fade_out_seconds

# Called when the node enters the scene tree for the first time.
func _ready():
	print("mmb_hint ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if timer > visibility_seconds:
		if timer < remove_after_seconds:
			var new_alpha = self.modulate.a - alpha_loss_speed * delta
			self.modulate = Color(original_color, new_alpha)
		else:
			self.queue_free()
