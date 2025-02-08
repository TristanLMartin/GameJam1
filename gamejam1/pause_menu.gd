extends Control

func _ready():
	$AnimationPlayer.play("RESET")
	hide()

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	hide()

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	show()

func testEsc():
	if get_node('/root/Main').game_state != get_node('/root/Main').game_states.PLAYING and get_node('/root/Main').game_state != get_node('/root/Main').game_states.PAUSE_MENU:
		return

	if Input.is_action_just_pressed("Pause") and get_tree().paused == false:
		get_node('/root/Main').game_state = get_node('/root/Main').game_states.PAUSE_MENU
		pause()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused == true:
		get_node('/root/Main').game_state = get_node('/root/Main').game_states.PLAYING
		resume()
 


func _on_resume_pressed():
	resume()


func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	testEsc()
