extends Label
var value = 0

func _ready() -> void:
	self.text = str(value)
	%Timer.start()

func _process(delta: float) -> void:
	self.text = str("$",value)




func _on_timer_timeout() -> void:
	queue_free()
