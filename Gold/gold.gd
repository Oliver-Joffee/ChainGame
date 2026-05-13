extends Node2D

var amount: int = randi_range(1, 10)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.gold += amount
		queue_free()
