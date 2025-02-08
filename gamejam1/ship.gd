extends Node2D

@export var SPEED := 10;
@onready var path_to_follow : PathFollow2D = %PathFollow2D

var bullet_scene

func _ready() -> void:
	bullet_scene = preload("res://bullet.tscn")

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
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_rotation = %PathFollow2D.global_rotation
	bullet_instance.global_position = %PathFollow2D.global_position * 1.2
	add_child(bullet_instance)
