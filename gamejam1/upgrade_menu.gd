extends Control

signal upgrade_requested(upgrade_id)

@export var upgrade1_counter = 0
@export var upgrade1_max = 3
@export var upgrade2_counter = 0
@export var upgrade2_max = 3
@export var upgrade7_counter = 0
@export var upgrade7_max = 4
@export var upgrade9_counter = 0
@export var upgrade9_max = 2
@export var upgrade10_counter = 0
@export var upgrade10_max = 2
@export var upgrade11_counter = 0
@export var upgrade11_max = 2


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
			%Upgrade10.disabled = false
			%Upgrade11.disabled = false
		"Upgrade5":
			emit_signal("upgrade_requested", "Upgrade5")
			%Upgrade5.disabled = true
			%Upgrade12.disabled = false
			%Upgrade13.disabled = false
			%Upgrade14.disabled = false
		"Upgrade6":
			emit_signal("upgrade_requested", "Upgrade6")
			%Upgrade6.disabled = true
			%Upgrade15.disabled = false
			%Upgrade16.disabled = false
			%Upgrade17.disabled = false
		"Upgrade7":
			if upgrade7_counter < upgrade7_max:
				upgrade7_counter += 1
				emit_signal("upgrade_requested", "Upgrade7")
				if upgrade7_counter == upgrade7_max:
					%Upgrade7.disabled = true
		"Upgrade8":
			emit_signal("upgrade_requested", "Upgrade8")
			%Upgrade8.disabled = true
		"Upgrade9":
			if upgrade9_counter < upgrade9_max:
				upgrade9_counter += 1
				emit_signal("upgrade_requested", "Upgrade9")
				if upgrade9_counter == upgrade9_max:
					%Upgrade9.disabled = true
		"Upgrade10":
			if upgrade10_counter < upgrade10_max:
				upgrade10_counter += 1
				emit_signal("upgrade_requested", "Upgrade10")
				if upgrade10_counter == upgrade10_max:
					%Upgrade10.disabled = true
		"Upgrade11":
			if upgrade11_counter < upgrade11_max:
				upgrade11_counter += 1
				emit_signal("upgrade_requested", "Upgrade11")
				if upgrade11_counter == upgrade11_max:
					%Upgrade11.disabled = true
		"Upgrade12":
			emit_signal("upgrade_requested", "Upgrade12")
			%Upgrade12.disabled = true
		"Upgrade13":
			emit_signal("upgrade_requested", "Upgrade13")
			%Upgrade13.disabled = true
		"Upgrade14":
			emit_signal("upgrade_requested", "Upgrade14")
			%Upgrade14.disabled = true
		"Upgrade16":
			emit_signal("upgrade_requested", "Upgrade16")
			%Upgrade16.disabled = true
		"Upgrade17":
			emit_signal("upgrade_requested", "Upgrade17")
			%Upgrade17.disabled = true
