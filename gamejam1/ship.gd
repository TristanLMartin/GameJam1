extends Node2D

@export var SPEED : int = 10
@onready var path_to_follow : PathFollow2D = %PathFollow2D
@onready var bullet_timer : Timer = $Bullet_CD

var bullet_scene

func _ready() -> void:
	bullet_scene = preload("res://bullet.tscn")
	$CowTimer.timeout.connect(_on_CowTimer_timeout)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot") and bullet_timer.is_stopped():
		shoot()
	$CowTimer.wait_time = cow_generation_time
	if Input.is_action_just_pressed("Place_Cow"):
		place_cows_on_planet()
	
	

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

#When has_cows_unlocked upgrade becomes true, we need to $CowTimer.start()
@export var has_cows_unlocked = false #If you have the upgrade or not
@export var cow_count = 0 #How many cows you have in your "inventory"
#When cows_placed++ and cow_count isn't a denomination, we need to resolve...
@export var cows_placed = 1 #How many cows you place per press
@export var cow_generation_time = 10.0
signal cow_signal(amount)

func _on_CowTimer_timeout() -> void:
	cow_count += cows_placed

func place_cows_on_planet() -> void:
	if has_cows_unlocked == true and cow_count >= cows_placed: #Checks if you have the cow upgrade and have cows off cooldown
		cow_count -= cows_placed #Takes cows from "inventory"
		emit_signal("cow_signal", cows_placed) #Sends a signal with amount of cows to place
	

#func satellite_left() -> void:
	

#func satellite_right() -> void:
	

#func place_mine() -> void:
	
