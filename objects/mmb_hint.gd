extends Label

var visibility_seconds := 3.0
var fade_out_seconds := 2.0
var remove_after_seconds := visibility_seconds + fade_out_seconds
var timer := 0.0

var originalColor: Color

# Called when the node enters the scene tree for the first time.
func _ready():
	originalColor = self.modulate


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if timer < visibility_seconds:
		pass
	else:
		if timer < remove_after_seconds:
			var alpha = self.modulate.a - fade_out_seconds * delta
			self.modulate = Color(originalColor, alpha)
		else:
			self.queue_free()
