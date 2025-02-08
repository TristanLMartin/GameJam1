extends Node2D

@export var SPEED := 10;
@onready var path_to_follow : PathFollow2D = %PathFollow2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot"):
		shoot()
	

func _physics_process(delta: float) -> void:
	var movement := 0
	if Input.is_action_pressed("Move_Left"):
		movement -= SPEED
	if Input.is_action_pressed("Move_Right"):
		movement += SPEED
	
	path_to_follow.progress += movement

func shoot() -> void:
	var bullet_scene = load("res://bullet.tscn")
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_rotation = self.global_rotation
	print(self.global_rotation)
	add_child(bullet_instance)
