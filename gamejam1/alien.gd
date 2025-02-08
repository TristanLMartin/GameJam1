extends CharacterBody2D

@onready var planet : Node2D = get_node("/root/Main/Planet")
@onready var wave_spawner = get_node('/root/Main/WaveSpawner')

func _physics_process(delta: float) -> void:
	var direction : Vector2 = global_position.direction_to(planet.global_position)
	velocity = direction * 500
	move_and_slide()
	

func on_hit() -> void:
	wave_spawner.alien_death.emit()
	queue_free()
