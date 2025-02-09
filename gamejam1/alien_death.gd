extends AnimatedSprite2D

func _ready() -> void:
	print("ready animation")
	animation_looped.connect(_end_animation)
	
func _end_animation() -> void:
	print("end animation")
	queue_free()
