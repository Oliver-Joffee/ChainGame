extends CharacterBody2D
class_name Enemy

@onready var player = Globals.Player

func damage(damage: float):
	print(damage)

func _process(delta: float) -> void:
	var target = player.global_position

	
	velocity = (target - global_position).normalized() * 500
	move_and_slide()
