extends Node2D


var wave_number := 1
const alien_scene : PackedScene = preload("res://alien.tscn")
signal alien_death

func _ready() -> void:
	alien_death.connect(_on_alien_death)

func _on_spawn_speed_timeout() -> void:
	spawn_monster()
	
func _on_alien_death():
	print("alien died")

func spawn_monster() -> void:
	if self.get_children().size() >= 5:
		return
	
	%spawn_speed.wait_time = randf_range(1, 3)
	var rand = RandomNumberGenerator.new()
	%PathFollow2D.progress_ratio = rand.randf()
	
	var alien = alien_scene.instantiate() as CharacterBody2D
	alien.global_position = %PathFollow2D.global_position
	add_child(alien)
	
	var aliens_spawned := 0
	
	aliens_spawned += 1
	
	#if aliens_spawned >= 5d:
		#print("Wave ", wave_number, " Completed!")
