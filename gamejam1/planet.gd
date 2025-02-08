extends StaticBody2D

var health = 1000
signal PlanetDeath

func take_damage(damage : int):
	health -= damage
	var health_bar : ProgressBar = get_node('/root/Main/CanvasLayer/PlanetHealth')
	health_bar.value = health
	
	

func _physics_process(delta: float) -> void:
	for body in %HurtBox.get_overlapping_bodies():
		take_damage(1)
