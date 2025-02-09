extends CharacterBody2D

@export var alien_type : int = 2
@onready var planet : Node2D = get_node("/root/Main/Planet")
@onready var wave_spawner = get_node('/root/Main/WaveSpawner')
@onready var main = get_node('/root/Main')
@onready var alien_deat_animation : PackedScene = preload("res://alien_death.tscn")
@export var gold_value : int = 15
var attacking = false
var charging = false
var health : int = 2
var laser_increasing = true
var wave_number

@export var speed_per_wave = 10
@export var base_speed = 50

func _ready() -> void:
	planet.PlanetCollision.connect(_planet_collision)
	wave_number = wave_spawner.wave_number
	base_speed = base_speed + (wave_number * speed_per_wave)

func _physics_process(delta: float) -> void:
	var direction : Vector2 = global_position.direction_to(planet.global_position)
	velocity = direction * base_speed
	move_and_slide()
	look_at(direction)
	rotate(-1.5)
	if laser_increasing:
		%Laser.scale.x += 0.1
	else:
		%Laser.scale.x -= 0.1
	if %Laser.scale.x >= 1:
		laser_increasing = false
	elif %Laser.scale.x <= 0.6:
		laser_increasing = true
	%LaserHit.rotate(0.1)

func _planet_collision(body):
		if charging or body != self:
			return
		%Timer.start()
		charging = true

func on_hit() -> void:
	health -= 1	
	$AnimationPlayer.play("Flash")
	if health <= 0:
		wave_spawner.alien_death.emit()
		main.add_gold(gold_value)
		var death_animation = alien_deat_animation.instantiate()
		death_animation.global_position = global_position

		death_animation.play()
		get_parent().add_child(death_animation)
		queue_free()


func _on_timer_timeout() -> void:
	attacking = true
	%Laser.visible = true
