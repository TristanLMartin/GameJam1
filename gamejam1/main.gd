extends Node

enum game_states {PAUSE_MENU, PLAYING, UPGRADING, START_MENU}
var game_state = game_states.PLAYING

#func _process(delta: float) -> void:
	#print(game_state)
