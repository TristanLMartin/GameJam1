extends StaticBody2D

@onready var upgrade_menu = get_node("/root/Main/CanvasLayer/Menus/UpgradeMenu")
@export var health = 100
@onready var healthLabel = get_node("/root/Main/CanvasLayer/PlanetHealth/HealthLabel")
var multiplier = 1
var multiplier_resistance = 0
@export var multiplier_increment = 0.8
signal PlanetDeath
signal PlanetCollision
var cow_quadrants = [0, 0, 0, 0]
@onready var cow_icons = [%Cow1, %Cow2, %Cow3, %Cow4]
@onready var cow_timers = [%QuadrantTimer1, %QuadrantTimer2, %QuadrantTimer3, %QuadrantTimer4]

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
	var is_attacked = [false, false, false, false]
	
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
				if cow_quadrants[quadrant.quadrant] <= 0:
					current_multiplier = 1
					total_damage += damage_done
					is_attacked[quadrant.quadrant] = true
				elif cow_timers[quadrant.quadrant].time_left <= 0:
					print("starting timer", cow_timers[quadrant.quadrant])
					cow_timers[quadrant.quadrant].start()
				
		multiplier += current_multiplier
	multiplier = max(multiplier - multiplier_resistance, 1)
	%MultiplierLabel.text = str(multiplier,  'x')
	
	for n in range(0, 4):
		if n == 0:
			%Quadrant1.light.visible = is_attacked[n]
		if n == 1:
			%Quadrant2.light.visible = is_attacked[n]
		if n == 2:
			%Quadrant3.light.visible = is_attacked[n]
		if n == 3:
			%Quadrant4.light.visible = is_attacked[n]
	take_damage(total_damage, delta)
	


var cows = 0
var research = 0

func _ready():
	var ship = get_node("/root/Main/Ship")
	ship.cow_signal.connect(_on_place_cows)
	ship.research_signal.connect(_on_place_research)
	%PlanetHealth.max_value = health
	upgrade_menu.connect("upgrade_requested", _on_upgrade_requested)
	
func _on_place_cows(amount, quadrant):
	cow_quadrants[quadrant - 1] = max(0, amount + cow_quadrants[quadrant - 1])
	
	for n in range(0, 4):
		var curr_cows = cow_quadrants[n]
		if curr_cows >= 1:
			cow_icons[n].visible = true
		else:
			cow_icons[n].visible = false
		cow_icons[n].get_children()[0].text = str(curr_cows) + 'x'
		
	print(cow_quadrants)
	
	
	print(quadrant)
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
			


func _on_quadrant_timer_timeout(extra_arg_0: int) -> void:
	%CowDeath.play()
	print("quadrant", extra_arg_0 + 1)
	_on_place_cows(-1, extra_arg_0 + 1)
