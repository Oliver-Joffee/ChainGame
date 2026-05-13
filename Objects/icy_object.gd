extends PhysicsObject

var ice: PackedScene = preload("res://Hazards/ice.tscn")
var lastPoint: Vector2 = global_position

func _process(delta: float) -> void:
	if $Area2D.get_overlapping_areas().size() == 0:
		var newIce = ice.instantiate()
		get_parent().add_child(newIce)
		newIce.global_position = global_position
		lastPoint = global_position
		
	#if abs(global_position.x - lastPoint.x) >= 256 || abs(global_position.y - lastPoint.y) >= 256:
		#var newIce = ice.instantiate()
		#get_parent().add_child(newIce)
		#newIce.global_position = (global_position - lastPoint).normalized() * 256 + lastPoint
		#newIce.set_deferred("monitoring", true)
		#lastPoint = global_position
