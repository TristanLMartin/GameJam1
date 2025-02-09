extends Node

enum game_states {PAUSE_MENU, PLAYING, UPGRADING, START_MENU}
var game_state = game_states.PLAYING

@export var gold_total = 0

func _ready() -> void:
	pass

#func _process(delta: float) -> void:
	#print(game_state)

func add_gold(gold) -> void:
	gold_total += gold
	print(gold_total)
	

func _on_planet_planet_death() -> void:
	print("this is the main script confirming death!")
	get_tree().reload_current_scene()
