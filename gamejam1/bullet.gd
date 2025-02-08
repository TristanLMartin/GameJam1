extends Area2D

@export var SPEED : int = 300
var RANGE : int = 1200
var travelled_distance : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction : Vector2 = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	travelled_distance += SPEED * delta
	
	if travelled_distance > RANGE:
		queue_free()
