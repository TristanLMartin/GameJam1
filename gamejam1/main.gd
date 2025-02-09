extends Node

enum game_states {PAUSE_MENU, PLAYING, UPGRADING, START_MENU}
var game_state = game_states.START_MENU

@export var gold_total : int = 0
@onready var gold_label = %Gold
@export var current_wave : int = 1
@onready var wave_label = %Wave

func _ready() -> void:
	gold_label.text = str("Gold: 0")
	get_tree().paused = true
	
func add_gold(gold) -> void:
	gold_total += gold
	gold_label.text = str('Gold: ', gold_total)
	
func subtract_gold(gold) -> void:
	gold_total -= gold
	gold_label.text = str('Gold: ', gold_total)

func _on_planet_planet_death() -> void:
	print("this is the main script confirming death!")
	get_tree().reload_current_scene()

func wave_update() -> void:
	current_wave += 1
	wave_label.text = str('Wave: ', current_wave)
