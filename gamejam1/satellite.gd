extends Node2D

@onready var upgrade_menu = get_node("/root/Main/CanvasLayer/Menus/UpgradeMenu")
@onready var path_to_follow : PathFollow2D = %PathFollow2D
@export var speed = 6

func _physics_process(delta) -> void:
	var movement = speed
	path_to_follow.progress += movement

func _on_area_2d_body_entered(body):
	body.on_hit()
	
func _ready():
	upgrade_menu.connect("upgrade_requested", _on_upgrade_requested)

func _on_upgrade_requested(upgrade_id):
	match upgrade_id:
		"Upgrade13":
			speed = 8
