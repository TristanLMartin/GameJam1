extends Node2D

@export var SPEED := 10;
@onready var path_to_follow : PathFollow2D = %PathFollow2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	

func _physics_process(delta: float) -> void:
	var movement := 0
	if Input.is_action_pressed("Move_Left"):
		movement -= SPEED
	if Input.is_action_pressed("Move_Right"):
		movement += SPEED
	
	path_to_follow.progress += movement
	
