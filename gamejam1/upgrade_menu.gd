extends Control

func _ready():
	$AnimationPlayer.play("RESET")
	hide()

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur2")
	hide()
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur2")
	show()

func testTab():
	if Input.is_action_just_pressed("Upgrade_Menu") and  get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("Upgrade_Menu") and get_tree().paused == true:
		resume()

func _process(delta):
	testTab()
