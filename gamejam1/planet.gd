extends StaticBody2D

@onready var upgrade_menu = get_node("/root/Main/CanvasLayer/Menus/UpgradeMenu")
@export var health = 100
@onready var healthLabel = get_node("/root/Main/CanvasLayer/PlanetHealth/HealthLabel")
var multiplier = 1
var multiplier_resistance = 0
@export var multiplier_increment = 0.8
signal PlanetDeath
signal PlanetCollision

func take_damage(damage : int, delta):
	health -= damage * multiplier * delta
	var health_bar : ProgressBar = get_node('/root/Main/CanvasLayer/PlanetHealth')
	health_bar.value = health
	if health <= 0.0:
		print("We're dead!")
		PlanetDeath.emit()
	

func _physics_process(delta: float) -> void:
	healthLabel.text = str(int(health))
	



	var quadrants = [%Quadrant1, %Quadrant2, %Quadrant3, %Quadrant4]
	
	multiplier = 0
	var total_damage = 0
	for quadrant in quadrants:
		var current_multiplier = 0
		var bodies = quadrant.get_overlapping_bodies()
		for body in bodies:
			PlanetCollision.emit(body)
			if body.attacking:
				var damage_done = 1
				if body.alien_type == 3:
					damage_done = 3
				if body.alien_type == 1:
					damage_done = 1
				if body.alien_type == 2:
					damage_done = 1
					print("damage done ", damage_done)
				print("attacking")
				current_multiplier = 1
				total_damage += damage_done
		multiplier += current_multiplier
	multiplier = max(multiplier - multiplier_resistance, 1)
	%MultiplierLabel.text = str(multiplier,  'x')
	
	take_damage(total_damage, delta)
	


var cows = 0
var research = 0

func _ready():
	var ship = get_node("/root/Main/Ship")
	ship.cow_signal.connect(_on_place_cows)
	ship.research_signal.connect(_on_place_research)
	%PlanetHealth.max_value = health
	upgrade_menu.connect("upgrade_requested", _on_upgrade_requested)
	
func _on_place_cows(amount):
	cows += amount
	
func _on_place_research(amount):
	research += amount
	
func _on_upgrade_requested(upgrade_id):
	match upgrade_id:
		"Upgrade7":
			%PlanetHealth.max_value += 50
			health += 50
		"Upgrade8":
			health = %PlanetHealth.max_value
		"Upgrade9":
			multiplier_resistance += multiplier_increment
			
