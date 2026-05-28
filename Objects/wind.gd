extends PhysicsObject

func damageBody(body: Enemy):
	body.damage(weight * velocity.length(), global_position, (weight * velocity.length() * 400))
