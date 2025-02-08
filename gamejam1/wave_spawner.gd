extends Node2D


var wave_number := 1
const alien_scene : PackedScene = preload("res://alien.tscn")

func _process(delta: float) -> void:
	if self.get_children().size() >= 10:
		return
	
	var rand = RandomNumberGenerator.new()
	%PathFollow2D.progress_ratio = rand.randf()
	
	var alien = alien_scene.instantiate() as CharacterBody2D
	alien.global_position = %PathFollow2D.global_position
	add_child(alien)
	
	
