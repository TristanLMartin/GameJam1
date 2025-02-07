extends Node2D

@export var SPEED := 100;
@onready var path_to_follow : PathFollow2D = %PathFollow2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	path_to_follow.progress += 1
	pass
