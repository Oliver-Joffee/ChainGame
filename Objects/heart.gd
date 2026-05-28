extends PhysicsObject

func damageBody(body: Enemy):
	body.damage(weight * velocity.length() * ((Globals.Player.health) / 100) + 1, global_position, weight * velocity.length() * 20)
