@tool
extends Path2D

@export var SIZE = 480
@export var NUM_POINTS = 500


func _ready() -> void:
	curve = Curve2D.new()
	for i in NUM_POINTS:
		curve.add_point(Vector2(0, -SIZE).rotated((i / float(NUM_POINTS)) * TAU))

	# End the circle.
	curve.add_point(Vector2(0, -SIZE))
	self.curve = curve
	print("path completed")
