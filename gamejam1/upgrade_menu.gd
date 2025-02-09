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
@export var upgrade1_cost = 0
@export var upgrade2_cost = 0
@export var upgrade3_cost = 0
@export var upgrade4_cost = 0
@export var upgrade5_cost = 0
@export var upgrade6_cost = 0
@export var upgrade7_cost = 0
@export var upgrade8_cost = 0
@export var upgrade9_cost = 0
@export var upgrade10_cost = 0
@export var upgrade11_cost = 0
@export var upgrade12_cost = 0
@export var upgrade13_cost = 0
@export var upgrade14_cost = 0
@export var upgrade16_cost = 0
@export var upgrade17_cost = 0
var button1_money = false
var button2_money = false
var button3_money = false
var button4_money = false
var button5_money = false
var button6_money = false
var button7_money = false
var button8_money = false
var button9_money = false
var button10_money = false
var button11_money = false
var button12_money = false
var button13_money = false
var button14_money = false
var button16_money = false
var button17_money = false
var button1_available = true
var button2_available = true
var button3_available = true
var button4_available = true
var button5_available = true
var button6_available = true
var button7_available = true
var button8_available = true
var button9_available = true
var button10_available = false
var button11_available = false
var button12_available = false
var button13_available = false
var button14_available = false
var button16_available = false
var button17_available = false
@onready var main = get_node("/root/Main")


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
	if main.gold_total >= upgrade1_cost:
		button1_money = true
	else:
		button1_money = false
	if main.gold_total >= upgrade2_cost:
		button2_money = true
	else:
		button2_money = false
	if main.gold_total >= upgrade3_cost:
		button3_money = true
	else:
		button3_money = false
	if main.gold_total >= upgrade4_cost:
		button4_money = true
	else:
		button4_money = false
	if main.gold_total >= upgrade5_cost:
		button5_money = true
	else:
		button5_money = false
	if main.gold_total >= upgrade6_cost:
		button6_money = true
	else:
		button6_money = false
	if main.gold_total >= upgrade7_cost:
		button7_money = true
	else:
		button7_money = false
	if main.gold_total >= upgrade8_cost:
		button8_money = true
	else:
		button8_money = false
	if main.gold_total >= upgrade9_cost:
		button9_money = true
	else:
		button9_money = false
	if main.gold_total >= upgrade10_cost:
		button10_money = true
	else:
		button10_money = false
	if main.gold_total >= upgrade11_cost:
		button11_money = true
	else:
		button11_money = false
	if main.gold_total >= upgrade12_cost:
		button12_money = true
	else:
		button12_money = false
	if main.gold_total >= upgrade13_cost:
		button13_money = true
	else:
		button13_money = false
	if main.gold_total >= upgrade14_cost:
		button14_money = true
	else:
		button14_money = false
	if main.gold_total >= upgrade16_cost:
		button16_money = true
	else:
		button16_money = false
	if main.gold_total >= upgrade17_cost:
		button17_money = true
	else:
		button17_money = false
	if button1_money == true and button1_available == true:
		%Upgrade1.disabled = false
	else:
		%Upgrade1.disabled = true
	if button2_money == true and button2_available == true:
		%Upgrade2.disabled = false
	else:
		%Upgrade2.disabled = true
	if button3_money == true and button3_available == true:
		%Upgrade3.disabled = false
	else:
		%Upgrade3.disabled = true
	if button4_money == true and button4_available == true:
		%Upgrade4.disabled = false
	else:
		%Upgrade4.disabled = true
	if button5_money == true and button5_available == true:
		%Upgrade5.disabled = false
	else:
		%Upgrade5.disabled = true
	if button6_money == true and button6_available == true:
		%Upgrade6.disabled = false
	else:
		%Upgrade6.disabled = true
	if button7_money == true and button7_available == true:
		%Upgrade7.disabled = false
	else:
		%Upgrade7.disabled = true
	if button8_money == true and button8_available == true:
		%Upgrade8.disabled = false
	else:
		%Upgrade8.disabled = true
	if button9_money == true and button9_available == true:
		%Upgrade9.disabled = false
	else:
		%Upgrade9.disabled = true
	if button10_money == true and button10_available == true:
		%Upgrade10.disabled = false
	else:
		%Upgrade10.disabled = true
	if button11_money == true and button11_available == true:
		%Upgrade11.disabled = false
	else:
		%Upgrade11.disabled = true
	if button12_money == true and button12_available == true:
		%Upgrade12.disabled = false
	else:
		%Upgrade12.disabled = true
	if button13_money == true and button13_available == true:
		%Upgrade13.disabled = false
	else:
		%Upgrade13.disabled = true
	if button14_money == true and button14_available == true:
		%Upgrade14.disabled = false
	else:
		%Upgrade14.disabled = true
	if button16_money == true and button16_available == true:
		%Upgrade16.disabled = false
	else:
		%Upgrade16.disabled = true
	if button17_money == true and button17_available == true:
		%Upgrade17.disabled = false
	else:
		%Upgrade17.disabled = true
	
	
func _on_button_pressed(button):
	match button:
		"Upgrade1":
			if upgrade1_counter < upgrade1_max and button1_money == true:
				main.subtract_gold(upgrade1_cost)
				upgrade1_counter += 1
				emit_signal("upgrade_requested", "Upgrade1")
				if upgrade1_counter == upgrade1_max:
					button1_available = false
		"Upgrade2":
			if upgrade2_counter < upgrade2_max and button2_money == true:
				main.subtract_gold(upgrade2_cost)
				upgrade2_counter += 1
				emit_signal("upgrade_requested", "Upgrade2")
				if upgrade2_counter == upgrade2_max:
					button2_available = false
		"Upgrade3":
			if button3_money == true:
				main.subtract_gold(upgrade3_cost)
				emit_signal("upgrade_requested", "Upgrade3")
				button3_available = false
		"Upgrade4":
			if button4_money == true:
				main.subtract_gold(upgrade4_cost)
				emit_signal("upgrade_requested", "Upgrade4")
				button4_available = false
				button10_available = true
				button11_available = true
		"Upgrade5":
			if button5_money == true:
				main.subtract_gold(upgrade5_cost)
				emit_signal("upgrade_requested", "Upgrade5")
				button5_available = false
				button12_available = true
				button13_available = true
				button14_available = true
		"Upgrade6":
			if button6_money == true:
				main.subtract_gold(upgrade6_cost)
				emit_signal("upgrade_requested", "Upgrade6")
				button6_available = false
				button16_available = true
				button17_available = true
		"Upgrade7":
			if upgrade7_counter < upgrade7_max and button7_money == true:
				main.subtract_gold(upgrade7_cost)
				upgrade7_counter += 1
				emit_signal("upgrade_requested", "Upgrade7")
				if upgrade7_counter == upgrade7_max:
					button7_available = false
		"Upgrade8":
			if button8_money == true:
				main.subtract_gold(upgrade8_cost)
				emit_signal("upgrade_requested", "Upgrade8")
				button8_available = false
		"Upgrade9":
			if upgrade9_counter < upgrade9_max and button9_money == true:
				main.subtract_gold(upgrade9_cost)
				upgrade9_counter += 1
				emit_signal("upgrade_requested", "Upgrade9")
				if upgrade9_counter == upgrade9_max:
					button9_available = false
		"Upgrade10":
			if upgrade10_counter < upgrade10_max and button10_money == true:
				main.subtract_gold(upgrade10_cost)
				upgrade10_counter += 1
				emit_signal("upgrade_requested", "Upgrade10")
				if upgrade10_counter == upgrade10_max:
					button10_available = false
		"Upgrade11":
			if upgrade11_counter < upgrade11_max and button11_money == true:
				main.subtract_gold(upgrade11_cost)
				upgrade11_counter += 1
				emit_signal("upgrade_requested", "Upgrade11")
				if upgrade11_counter == upgrade11_max:
					button11_available = false
		"Upgrade12":
			if button12_money == true:
				main.subtract_gold(upgrade12_cost)
				emit_signal("upgrade_requested", "Upgrade12")
				button12_available = false
		"Upgrade13":
			if button13_money == true:
				main.subtract_gold(upgrade13_cost)
				emit_signal("upgrade_requested", "Upgrade13")
				button13_available = false
		"Upgrade14":
			if button14_money == true:
				main.subtract_gold(upgrade14_cost)
				emit_signal("upgrade_requested", "Upgrade14")
				button14_available = false
		"Upgrade16":
			if button16_money == true:
				main.subtract_gold(upgrade16_cost)
				emit_signal("upgrade_requested", "Upgrade16")
				button16_available = false
		"Upgrade17":
			if button17_money == true:
				main.subtract_gold(upgrade17_cost)
				emit_signal("upgrade_requested", "Upgrade17")
				button17_available = false
