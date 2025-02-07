extends Node2D

@export var SPEED := 10;
@onready var path_to_follow : PathFollow2D = %PathFollow2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	
	if direction.x > 0:
		path_to_follow.progress += SPEED
	elif direction.x < 0:
		path_to_follow.progress -= SPEED
	
