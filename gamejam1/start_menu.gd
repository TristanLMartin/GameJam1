extends Control

@onready var main_music = get_node('/root/Main/MainMusic')
var resolutions =[
[1024,576],
[1152,648],
[1280,720],
[1366,768],
[1600,900],
[1920,1080],
[2560,1440],
]

func _on_button_pressed() -> void:
	hide()
	get_node('/root/Main').game_state = get_node('/root/Main').game_states.PLAYING
	get_tree().paused = false


func _on_quit_pressed():
	get_tree().quit()


func _on_button_settings_pressed() -> void:
	%HTTPRequest.request_leaderboard()

func _on_music_slider_value_changed(value: float) -> void:
	main_music.volume_linear = value * value * 0.001
	print(main_music.volume_linear)


func _on_resolution_selected(index: int) -> void:
	DisplayServer.window_set_size(Vector2(resolutions[index][0], resolutions[index][1]))
