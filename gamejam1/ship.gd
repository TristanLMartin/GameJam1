extends Node2D

@export var SPEED : int = 10
@onready var path_to_follow : PathFollow2D = %PathFollow2D
@onready var bullet_timer : Timer = $Bullet_CD

var bullet_scene

func _ready() -> void:
	bullet_scene = preload("res://bullet.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot") and bullet_timer.is_stopped():
		shoot()
	

func _physics_process(delta: float) -> void:
	var movement := 0
	if Input.is_action_pressed("Move_Left"):
		movement -= SPEED
	if Input.is_action_pressed("Move_Right"):
		movement += SPEED
	
	path_to_follow.progress += movement

func shoot() -> void:
	bullet_timer.start()
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_rotation = %PathFollow2D.global_rotation
	bullet_instance.global_position = %PathFollow2D.global_position * 1.2
	add_child(bullet_instance)
