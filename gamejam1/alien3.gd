extends CharacterBody2D

@export var alien_type : int = 3 #the alien type
@onready var planet : Node2D = get_node("/root/Main/Planet")
@onready var wave_spawner = get_node('/root/Main/WaveSpawner')
@onready var alien_deat_animation : PackedScene = preload("res://alien_death.tscn")
@onready var main = get_node('/root/Main')
@export var gold_value : int = 10
var attacking = false
var charging = false


func _ready() -> void:
	planet.PlanetCollision.connect(_planet_collision)

func _physics_process(delta: float) -> void:
	var direction : Vector2 = global_position.direction_to(planet.global_position)
	velocity = direction * 125
	move_and_slide()
	look_at(direction)
	rotate(-1.5)

func _planet_collision(body):
		if charging or body != self:
			return
		%Timer.start()
		charging = true

func on_hit() -> void:
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
