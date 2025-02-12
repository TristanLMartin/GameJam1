extends Control

@onready var main_music = get_node('/root/Main/MainMusic')

func _on_music_slider_value_changed(value: float) -> void:
	main_music.volume_linear = value * value * 0.001
