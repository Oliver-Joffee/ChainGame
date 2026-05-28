extends PhysicsObject

func bounceSpecVel(normal: Vector2):
	var enemies: Array = get_enemies()
	
	specVel = (enemies[0].global_position - global_position).normalized() * velocity.length()
