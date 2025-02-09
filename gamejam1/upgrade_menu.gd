extends Control

signal upgrade_requested(upgrade_id)

@export var upgrade1_counter = 0
@export var upgrade1_max = 3
@export var upgrade2_counter = 0
@export var upgrade2_max = 3


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
	if get_node('/root/Main').game_state != get_node('/root/Main').game_states.PLAYING and get_node('/root/Main').game_state != get_node('/root/Main').game_states.UPGRADING:
		return
	if Input.is_action_just_pressed("Upgrade_Menu") and  get_tree().paused == false:
		get_node('/root/Main').game_state = get_node('/root/Main').game_states.UPGRADING
		pause()
	elif Input.is_action_just_pressed("Upgrade_Menu") and get_tree().paused == true:
		get_node('/root/Main').game_state = get_node('/root/Main').game_states.PLAYING
		resume()

func _process(delta):
	testTab()
	
func _on_button_pressed(button):
	match button:
		"Upgrade1":
			if upgrade1_counter < upgrade1_max:
				upgrade1_counter += 1
				emit_signal("upgrade_requested", "Upgrade1")
				if upgrade1_counter == upgrade1_max:
					%Upgrade1.disabled = true
		"Upgrade2":
			if upgrade2_counter < upgrade2_max:
				upgrade2_counter += 1
				emit_signal("upgrade_requested", "Upgrade2")
				if upgrade2_counter == upgrade2_max:
					%Upgrade2.disabled = true
		"Upgrade3":
			emit_signal("upgrade_requested", "Upgrade3")
			%Upgrade3.disabled = true
		"Upgrade4":
			emit_signal("upgrade_requested", "Upgrade4")
			%Upgrade4.disabled = true
		"Upgrade5":
			emit_signal("upgrade_requested", "Upgrade5")
			%Upgrade5.disabled = true
		"Upgrade6":
			emit_signal("upgrade_requested", "Upgrade6")
			%Upgrade6.disabled = true
		"Upgrade7":
			emit_signal("upgrade_requested", "Upgrade7")
		"Upgrade8":
			emit_signal("upgrade_requested", "Upgrade8")
		"Upgrade9":
			emit_signal("upgrade_requested", "Upgrade9")
		"Upgrade10":
			emit_signal("upgrade_requested", "Upgrade10")
		"Upgrade11":
			emit_signal("upgrade_requested", "Upgrade11")
		"Upgrade12":
			emit_signal("upgrade_requested", "Upgrade12")
		"Upgrade13":
			emit_signal("upgrade_requested", "Upgrade13")
		"Upgrade14":
			emit_signal("upgrade_requested", "Upgrade14")
		"Upgrade15":
			emit_signal("upgrade_requested", "Upgrade15")
		"Upgrade16":
			emit_signal("upgrade_requested", "Upgrade16")
			%Upgrade16.disabled = true
		"Upgrade17":
			emit_signal("upgrade_requested", "Upgrade17")
			%Upgrade17.disabled = true
