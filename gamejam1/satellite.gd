extends Node2D

@onready var path_to_follow : PathFollow2D = %PathFollow2D
@export var speed = 6

func _physics_process(delta) -> void:
	var movement = speed
	path_to_follow.progress += movement

func _on_area_2d_body_entered(body):
	body.on_hit()
