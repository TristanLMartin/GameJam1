extends Control

@onready var main_music = get_node('/root/Main/MainMusic')

func _on_button_pressed() -> void:
	hide()
	get_node('/root/Main').game_state = get_node('/root/Main').game_states.PLAYING
	get_tree().paused = false


func _on_quit_pressed():
	get_tree().quit()


func _on_button_settings_pressed() -> void:
	print("settings")

func _on_music_slider_value_changed(value: float) -> void:
	main_music.volume_linear = value * value * 0.001
