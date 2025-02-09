extends StaticBody2D

var health = 1000
var multiplier = 1
signal PlanetDeath
signal PlanetCollision

func take_damage(damage : int):
	health -= damage * multiplier
	var health_bar : ProgressBar = get_node('/root/Main/CanvasLayer/PlanetHealth')
	health_bar.value = health
	if health <= 0.0:
		print("We're dead!")
		PlanetDeath.emit()
	

func _physics_process(delta: float) -> void:

	var quadrants = [%Quadrant1, %Quadrant2, %Quadrant3, %Quadrant4]
	
	multiplier = 0
	var total_damage = 0
	for quadrant in quadrants:
		var current_multiplier = 0
		var bodies = quadrant.get_overlapping_bodies()
		for body in bodies:
			PlanetCollision.emit(body)
			if body.attacking:
				print("attacking")
				current_multiplier = 1
				total_damage += bodies.size()
		multiplier += current_multiplier
	%MultiplierLabel.text = str(multiplier,  'x')
	
	take_damage(total_damage)


var cows = 0

func _ready():
	var ship = get_node("/root/Main/Ship")
	ship.cow_signal.connect(_on_place_cows)
	
func _on_place_cows(amount):
	cows += amount
	print(cows)
