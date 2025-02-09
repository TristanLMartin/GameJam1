extends "res://cd_circle.gd"

@onready var teleport_cd = get_node("/root/Main/Ship/Teleport_CD")

func _ready() -> void:
	update()
	hide()

func update() -> void:
	$Label.text = "CTRL"
	$TextureProgressBar.max_value = teleport_cd.wait_time
