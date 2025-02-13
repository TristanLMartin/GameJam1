extends Control

func _ready():
	hide()



func _on_main_menu_button_pressed() -> void:
	get_node('/root/Main').game_state = get_node('/root/Main').game_states.START_MENU
	%StartMenu.show()
	print('hugh')
	hide()


func _on_reload_button_pressed() -> void:
	%HTTPRequest.request_leaderboard()
	draw_rankings()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	print("visible leaderboard")
	draw_rankings()
	


func draw_rankings() -> void:
	for child in %Rankings.get_children():
		child.queue_free()
	for row in %HTTPRequest.leaderboard_rankings:
		var label = Label.new()
		print("new label", row)
		label.text = row[0] + ": " + str(row[1])
		%Rankings.add_child(label)
		
