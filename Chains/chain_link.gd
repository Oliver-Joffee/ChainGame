extends RigidBody2D
@export var link: Node2D
var oldRotation: float

func _process(delta: float) -> void:
	if link != null:
		link.update($Marker2D.global_position)
		
func update(newPosition: Vector2):
	var target: Vector2 = $Marker2D.global_position
	look_at(target)
	global_position = newPosition
	
