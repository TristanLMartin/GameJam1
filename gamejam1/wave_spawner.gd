extends Node2D


var wave_number := 1
const alien_scene : PackedScene = preload("res://alien.tscn")
const alien_scene2 : PackedScene = preload("res://alien2.tscn")
const alien_scene3 : PackedScene = preload("res://alien3.tscn")
signal alien_death
var aliens_killed_in_wave := 0
var wave_in_progress := true #wave check
var max_enemies = 5 * wave_number #scaling enemy total based on wave

func _ready() -> void:
	alien_death.connect(_on_alien_death)

func _on_spawn_speed_timeout() -> void:
	if wave_in_progress:
		spawn_monster()
	
func _on_alien_death():
	aliens_killed_in_wave += 1
	print("alien died in wave ", wave_number, ": ", aliens_killed_in_wave)
	
	if aliens_killed_in_wave >= 5 * wave_number:
		print("Wave ", wave_number, " Completed!") #can use this as wave checker, add 1 every time completed
		wave_in_progress = false
		
		start_next_wave()

func spawn_monster() -> void:
	if max_enemies == 0:
		return
	
	#if self.get_children().size() >= 5: #aliens are always -2 this value because of 2 children counted under wavespawner
		#return
	
	%spawn_speed.wait_time = randf_range(1, 3)
	var rand = RandomNumberGenerator.new()
	%PathFollow2D.progress_ratio = rand.randf()
	
	var alien = alien_scene.instantiate() as CharacterBody2D
	var alien2 = alien_scene2.instantiate() as CharacterBody2D
	var alien3 = alien_scene3.instantiate() as CharacterBody2D
	
	alien.global_position = %PathFollow2D.global_position
	%PathFollow2D.progress_ratio = rand.randf()
	alien2.global_position = %PathFollow2D.global_position
	%PathFollow2D.progress_ratio = rand.randf()
	alien3.global_position = %PathFollow2D.global_position
	add_child(alien)
	add_child(alien2)
	add_child(alien3)
	max_enemies -= 1
	
func start_next_wave() -> void:
	await get_tree().create_timer(3.0).timeout
	wave_number += 1
	aliens_killed_in_wave = 0
	wave_in_progress = true
	
	max_enemies = 5 * wave_number
	print("Next wave starting! Total enemies to kill: ", max_enemies)
	
