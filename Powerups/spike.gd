extends PhysicsObject

func damageBody(body: Enemy):
	if velocity.length() == 0:
	
		body.damage(weight * 100, global_position, 2000)
