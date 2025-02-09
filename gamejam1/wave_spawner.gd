extends Node2D

var ENEMY_NUM = 10

var wave_number := 1
const alien_scene1 : PackedScene = preload("res://alien1.tscn")
const alien_scene2 : PackedScene = preload("res://alien2.tscn")
const alien_scene3 : PackedScene = preload("res://alien3.tscn")
signal alien_death
# signal alien_speed
var aliens_killed_in_wave := 0
var wave_in_progress := true #wave check
var max_enemies = ENEMY_NUM * wave_number #scaling enemy total based on wave
@onready var main = get_node("/root/Main")

func _ready() -> void:
	alien_death.connect(_on_alien_death)
	#alien_speed.connect()

func _on_spawn_speed_timeout() -> void:
	if wave_in_progress:
		spawn_monster()
	
func _on_alien_death():
	aliens_killed_in_wave += 1
	print("alien died in wave ", wave_number, ": ", aliens_killed_in_wave)
	
	if aliens_killed_in_wave >= ENEMY_NUM * wave_number:
		print("Wave ", wave_number, " Completed!") #can use this as wave checker, add 1 every time completed
		wave_in_progress = false
		
		start_next_wave()

func spawn_monster() -> void:
	if max_enemies == 0:
		return
		
		
	
	var adjusted_wait_time = randf_range(0, max(1, 2 - wave_number * 0.1))
	%spawn_speed.wait_time = adjusted_wait_time
	#%spawn_speed.wait_time = randf_range(1, 3)
	
	var rand = RandomNumberGenerator.new()
	%PathFollow2D.progress_ratio = rand.randf()

	
	# Randomly decide which alien to spawn
	var alien_type = rand.randi_range(1, 3)
	var alien : CharacterBody2D
	
	

	if alien_type == 1:
		alien = alien_scene1.instantiate() as CharacterBody2D
	elif alien_type == 2:
		alien = alien_scene2.instantiate() as CharacterBody2D
	else:
		alien = alien_scene3.instantiate() as CharacterBody2D

	alien.global_position = %PathFollow2D.global_position
	add_child(alien)
	max_enemies -= 1
	
func start_next_wave() -> void:
	await get_tree().create_timer(3.0).timeout
	wave_number += 1
	main.wave_update()
	aliens_killed_in_wave = 0
	wave_in_progress = true
	# alien_speed.emit(wave_number) #testing alien speed per wave
	
	max_enemies = ENEMY_NUM * wave_number
	print("Next wave starting! Total enemies to kill: ", max_enemies)
	
