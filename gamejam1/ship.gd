extends Node2D

@export var SPEED : int = 8
@export var Dash_Multiplier : float = 3.0
@export var dash_length : float = .2
@onready var path_to_follow : PathFollow2D = %PathFollow2D
@onready var bullet_timer : Timer = $Bullet_CD
@onready var dash_timer : Timer = $Dash_CD
@onready var teleport_timer : Timer = $Teleport_CD
@onready var upgrade_menu = get_node("/root/Main/CanvasLayer/Menus/UpgradeMenu")

var bullet_scene
var dashing : bool = false
var dash_length_timer : Timer


func _ready() -> void:
	bullet_scene = preload("res://bullet.tscn")
	#$CowTimer.timeout.connect(_on_CowTimer_timeout)
	upgrade_menu.connect("upgrade_requested", _on_upgrade_requested)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot") and bullet_timer.is_stopped():
		shoot()
	#$CowTimer.wait_time = cow_generation_time
	%CowTimer.wait_time = cow_generation_time
	if Input.is_action_just_pressed("Place_Cow"):
		place_cows_on_planet()
	
	if Input.is_action_just_pressed("Dash") and dash_timer.is_stopped():
		print("dash")
		dash()
	
	if Input.is_action_just_pressed("Teleport") and teleport_timer.is_stopped():
		print("teleport")
		teleport()


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
	%ShootSound.play()

func _on_upgrade_requested(upgrade_id):
	match upgrade_id:
		"Upgrade1":
			SPEED += 2
		"Upgrade2":
			bullet_timer.set_wait_time(bullet_timer.get_wait_time() - 0.3)
		"Upgrade4":
			print("You have cows!")
			has_cows_unlocked = true
			%CowTimer.start()
			%CowTimer.timeout.connect(_on_CowTimer_timeout)

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
	

func teleport() -> void:
	teleport_timer.start()
	if path_to_follow.progress_ratio <= .5:
		path_to_follow.progress_ratio += .5
	else:
		path_to_follow.progress_ratio -= .5


@export var has_cows_unlocked = false #If you have the upgrade or not
@export var cow_count = 1 #How many cows you have in your "inventory"
#We need to resolve when cow_count isn't a denomination of cows_placed (when the upgrade is bought)
@export var cows_placed = 1 #How many cows you place per press
@export var cow_generation_time = 10.0
signal cow_signal(amount)

func _on_CowTimer_timeout() -> void:
	cow_count += cows_placed

func place_cows_on_planet() -> void:
	if has_cows_unlocked == true and cow_count >= cows_placed: #Checks if you have the cow upgrade and have cows off cooldown
		cow_count -= cows_placed #Takes cows from "inventory"
		cow_signal.emit(cows_placed) #Sends a signal with amount of cows to place
		print("cow placed")
	


#func satellite_left() -> void:
	

#func satellite_right() -> void:
	

#func place_mine() -> void:
	
