extends CharacterBody2D

@onready var planet : Node2D = get_node("/root/Main/Planet")
@onready var wave_spawner = get_node('/root/Main/WaveSpawner')
@onready var main = get_node('/root/Main')
@export var gold_value : int = 15
var attacking = false
var charging = false
var health : int = 2

func _ready() -> void:
	planet.PlanetCollision.connect(_planet_collision)

func _physics_process(delta: float) -> void:
	var direction : Vector2 = global_position.direction_to(planet.global_position)
	velocity = direction * 75
	move_and_slide()

func _planet_collision(body):
		if charging or body != self:
			return
		%Timer.start()
		charging = true

func on_hit() -> void:
	health -= 1
	#wave_spawner.alien_death.emit()
	#queue_free()
	
	if health <= 0:
		wave_spawner.alien_death.emit()
		main.add_gold(gold_value)
		queue_free()


func _on_timer_timeout() -> void:
	attacking = true
