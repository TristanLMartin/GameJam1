extends Control



func _on_button_pressed() -> void:
	hide()
	get_node('/root/Main').game_state = get_node('/root/Main').game_states.PLAYING
	get_tree().paused = false
