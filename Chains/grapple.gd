extends Area2D

class object:
	var physic: PhysicsObject
	var relative: Vector2

var objects: Array[object]

func objectIn(object: PhysicsObject) -> bool:
	for i in objects:
		if i.physic == object:
			return true
			
	return false

func _on_body_entered(body: Node2D) -> void:
	if body is PhysicsObject:
		if !objectIn(body):
			var newObject = object.new()
			
			newObject.physic = body
			newObject.physic.attached = true
			newObject.relative = body.global_position - global_position
			
			objects.append(newObject)
		
		
		
func _physics_process(delta: float) -> void:
	for o in objects:
		$Marker2D.position = o.relative
		o.physic.global_position = to_global($Marker2D.position)
		o.physic.rotation_degrees = rotation_degrees
