extends PhysicsObject

func bounceSpecVel(normal: Vector2):
	
	specVel = (Globals.Player.global_position - global_position).normalized() * velocity.length()
