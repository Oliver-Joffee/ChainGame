extends Hazard
class_name Ice

var bodyFricDict: Dictionary[PhysicsObject, float]

func exitEffect(body):

	if body is PhysicsObject:
		body.friction = body.originalFriction
		
func effect(body):

	if body is PhysicsObject:
		body.friction = 1
