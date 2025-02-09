extends Node2D

signal cow_signal(amount)
signal research_signal(amount)

@export var SPEED : int = 8
@export var Dash_Multiplier : float = 3.0
@export var dash_length : float = .2
@export var has_laser = false
@export var laser_active = false
@export var laser_available = true
@export var has_cows_unlocked = false #If you have the upgrade or not
@export var cow_count = 1 #How many cows you have in your "inventory"
@export var cows_placed = 1 #How many cows you place per press
@export var cow_generation_time = 10.0
@export var has_satellites_unlocked = false
@export var satellite_count = 1
@export var satellite_life = 5.0
@export var satellite_generation_time = 20.0
@export var has_research_unlocked = false
@export var research_count = 1
@export var has_dash_unlocked = false
@export var has_teleport_unlocked = false
var teleporting = false
var previous_teleport_location
@onready var path_to_follow : PathFollow2D = %PathFollow2D
@onready var bullet_timer : Timer = $Bullet_CD
@onready var dash_timer : Timer = $Dash_CD
@onready var teleport_timer : Timer = $Teleport_CD
@onready var upgrade_menu = get_node("/root/Main/CanvasLayer/Menus/UpgradeMenu")
@onready var satellite = get_node("/root/Main/Satellite")
@onready var satellite_collision = get_node("/root/Main/Satellite/Path2D/PathFollow2D/Area2D/SatelliteCollision")
var laser_scene
var laser_instance
var bullet_scene
var dashing : bool = false
var dash_length_timer : Timer


func _ready() -> void:
	bullet_scene = preload("res://bullet.tscn")
	laser_scene = preload("res://laser.tscn")
	upgrade_menu.connect("upgrade_requested", _on_upgrade_requested)

func _process(delta: float) -> void:
	print(cow_count)
	if Input.is_action_just_pressed("Shoot") and has_laser == true and laser_active == false and laser_available == true:
		laser()
	elif Input.is_action_just_pressed("Shoot") and bullet_timer.is_stopped() and laser_active == false:
		shoot()
		
	if Input.is_action_just_pressed("Place_Cow"):
		place_cows_on_planet()
		
	if Input.is_action_just_pressed("Satellite_Spawn"):
		print("clicked satellite")
		place_satellite_spawn()
		
	if Input.is_action_just_pressed("Place_Research"):
		place_research_on_planet()
	
	if has_dash_unlocked:
		if Input.is_action_just_pressed("Dash") and dash_timer.is_stopped():
			print("dash")
			dash()
	
	if has_teleport_unlocked:
		if Input.is_action_just_pressed("Teleport") and teleport_timer.is_stopped():
			print("teleport")
			teleport()
	
	if teleporting:
		%TeleportAnimation.rotate(0.03)
		%TeleportAnimation.scale.x += 0.01
		%TeleportAnimation.scale.y += 0.01
		if %TeleportAnimationGhost.scale.x >= 0:
			%TeleportAnimationGhost.rotate(-0.03)
			%TeleportAnimationGhost.scale.x -= 0.01
			%TeleportAnimationGhost.scale.y -= 0.01
		if %TeleportAnimation.scale.x >= 0.6:
			teleporting = false
			%TeleportAnimation.scale.x = 0
			%TeleportAnimation.scale.y = 0
	if laser_active == true:
		laser_instance.global_rotation = %PathFollow2D.global_rotation
		laser_instance.global_position = %PathFollow2D.global_position * 1.2
	


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

func laser() -> void:
	laser_instance = laser_scene.instantiate()
	laser_active = true
	laser_available = false
	add_child(laser_instance)
	%LaserActive.start()
	%LaserActive.timeout.connect(_on_LaserActive_timeout)
	%LaserCooldown.start()
	%LaserCooldown.timeout.connect(_on_LaserCooldown_timeout)
	

func _on_LaserActive_timeout() -> void:
	laser_active = false
	laser_instance.queue_free()
	

func _on_LaserCooldown_timeout() -> void:
	laser_available = true

func _on_upgrade_requested(upgrade_id):
	match upgrade_id:
		"Upgrade1":
			SPEED += 2
		"Upgrade2":
			bullet_timer.set_wait_time(bullet_timer.get_wait_time() - 0.3)
		"Upgrade3":
			has_laser = true
		"Upgrade4":
			has_cows_unlocked = true
			%CowTimer.start()
			%CowTimer.timeout.connect(_on_CowTimer_timeout)
		"Upgrade5":
			has_satellites_unlocked = true
		"Upgrade6":
			has_research_unlocked = true
		"Upgrade10":
			cow_count = (round(cow_count * cows_placed) / (cows_placed + 1)) + 1
			cows_placed += 1
		"Upgrade11":
			cow_generation_time -= 2.5
			%CowTimer.wait_time = cow_generation_time
		"Upgrade12":
			satellite_life += 2.5
			%SatelliteTimer.wait_time = satellite_life
		"Upgrade14":
			satellite_generation_time -= 5.0
			%SatelliteCooldownTimer.wait_time = satellite_generation_time
		"Upgrade16":
			has_dash_unlocked = true
		"Upgrade17":
			has_teleport_unlocked = true

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
	%TeleportSound.play()
	%TeleportAnimationGhost.scale.x = 0.3
	%TeleportAnimationGhost.scale.y = 0.3
	%TeleportAnimationGhost.global_position = %PathFollow2D.global_position
	teleporting = true
	teleport_timer.start()
	if path_to_follow.progress_ratio <= .5:
		path_to_follow.progress_ratio += .5
	else:
		path_to_follow.progress_ratio -= .5


func _on_CowTimer_timeout() -> void:
	cow_count += 1

func place_cows_on_planet() -> void:
	var quadrant = int(floor(%PathFollow2D.progress_ratio / 0.25) + 1)
	if has_cows_unlocked == true and cow_count > 0:
		cow_count -= 1 #Takes cows from "inventory"
		cow_signal.emit(cows_placed, quadrant) #Sends a signal with amount of cows to place
	
func _on_SatelliteTimer_timeout() -> void:
	satellite.visible = false
	satellite_collision.disabled = true
	print("we made it")

func _on_SatelliteCooldownTimer_timeout() -> void:
	satellite_count += 1
	
func place_satellite_spawn() -> void:
	if has_satellites_unlocked == true and satellite_count > 0:
		satellite_count -= 1
		satellite.visible = true
		satellite_collision.disabled = false
		print("still going")
		%SatelliteTimer.start()
		%SatelliteTimer.timeout.connect(_on_SatelliteTimer_timeout)
		%SatelliteCooldownTimer.start()
		%SatelliteCooldownTimer.timeout.connect(_on_SatelliteCooldownTimer_timeout)


func place_research_on_planet() -> void:
	if has_research_unlocked == true and research_count > 0:
		research_count -= 1
		research_signal.emit(research_count)
		
	
