extends "res://cd_circle.gd"

func _ready() -> void:
	update()
	hide()

func update() -> void:
	$Label.text = "E"
	$TextureProgressBar.max_value = %SatelliteCooldownTimer.wait_time
