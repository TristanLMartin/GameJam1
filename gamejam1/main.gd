extends Node

enum game_states {PAUSE_MENU, PLAYING, UPGRADING, START_MENU, LEADERBOARD}
var game_state = game_states.START_MENU

@export var gold_total : int = 0
@onready var gold_label = %Gold
@export var current_wave : int = 1
@onready var wave_label = %Wave

@onready var teleport_cd = get_node("Ship/Teleport_CD")

func _ready() -> void:
	gold_label.text = str("Gold: 0")
	get_tree().paused = true

func _process(delta: float) -> void:
	$CanvasLayer/CD_Satellite.set_value(%SatelliteCooldownTimer.wait_time - %SatelliteCooldownTimer.time_left)
	$CanvasLayer/CD_Teleport.set_value(teleport_cd.wait_time - teleport_cd.time_left)
	$CanvasLayer/CD_Cow.set_value(%CowTimer.wait_time - %CowTimer.time_left)

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
