extends "res://cd_circle.gd"

func _ready() -> void:
	update()
	hide()
	
func update() -> void:
	$Label.text = "S"
	$TextureProgressBar.max_value = %CowTimer.wait_time
