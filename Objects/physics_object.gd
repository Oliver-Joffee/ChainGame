extends PhysicsObject

func bounceSpecVel(normal: Vector2):
	specVel = velocity.bounce(normal) * 2
