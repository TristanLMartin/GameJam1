extends Node2D

@export var SPEED : int = 8
@export var Dash_Multiplier : float = 3.0
@export var dash_length : float = .2
@onready var path_to_follow : PathFollow2D = %PathFollow2D
@onready var bullet_timer : Timer = $Bullet_CD
@onready var dash_timer : Timer = $Dash_CD

var bullet_scene
var dashing : bool = false
var dash_length_timer : Timer

func _ready() -> void:
	bullet_scene = preload("res://bullet.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot") and bullet_timer.is_stopped():
		shoot()
	
	if Input.is_action_just_pressed("Dash") and dash_timer.is_stopped():
		print("dash")
		dash()
		
	

func _physics_process(delta: float) -> void:
	var movement := 0
	var velocity : float
	if dashing:
		velocity = SPEED * Dash_Multiplier
	else:
		velocity = SPEED
		
	if Input.is_action_pressed("Move_Left"):
		movement -= velocity
	if Input.is_action_pressed("Move_Right"):
		movement += velocity
	
	path_to_follow.progress += movement

func shoot() -> void:
	bullet_timer.start()
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_rotation = %PathFollow2D.global_rotation
	bullet_instance.global_position = %PathFollow2D.global_position * 1.2
	add_child(bullet_instance)

func dash() -> void:
	dashing = true
	dash_timer.start()
	
	dash_length_timer = Timer.new()
	add_child(dash_length_timer)
	dash_length_timer.set_wait_time(dash_length)
	dash_length_timer.one_shot = true
	dash_length_timer.timeout.connect(_on_timer_timeout_dash_length)
	dash_length_timer.start()


func _on_timer_timeout_dash_length() -> void:
	dashing = false
	
