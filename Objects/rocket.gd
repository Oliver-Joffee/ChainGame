extends PhysicsObject

func bounceSpecVel(normal: Vector2):
	specVel = Vector2(0, 0)
	queue_free()
