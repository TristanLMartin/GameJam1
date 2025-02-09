extends Node

enum game_states {PAUSE_MENU, PLAYING, UPGRADING, START_MENU}
var game_state = game_states.PLAYING

@export var gold_total : int = 0
@onready var gold_label = %Gold

func _ready() -> void:
	gold_label.text = str("Gold: 0")

#func _process(delta: float) -> void:
	#print(game_state)

func add_gold(gold) -> void:
	gold_total += gold
	gold_label.text = str('Gold: ', gold_total)
	
func subtract_gold(gold) -> void:
	gold_total -= gold
	gold_label.text = str('Gold: ', gold_total)

func _on_planet_planet_death() -> void:
	print("this is the main script confirming death!")
	get_tree().reload_current_scene()
