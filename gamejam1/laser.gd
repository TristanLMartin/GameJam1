extends Area2D

var laser_increasing = true

func _on_body_entered(body):
	body.on_hit()

func _process(delta: float) -> void:
	if laser_increasing:
		%LaserSprite.scale.x += 0.1
	else:
		%LaserSprite.scale.x -= 0.1
	if %LaserSprite.scale.x >= 1.5:
		laser_increasing = false
	elif %LaserSprite.scale.x <= 0.6:
		laser_increasing = true
	
