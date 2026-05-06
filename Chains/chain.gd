extends Node2D

var max: float = 112

class Point:
	var currentPosition: Vector2 = Vector2(0,0)
	var oldPosition: Vector2 = Vector2(0,0)
	var neighbor: Point
	var newPosition: Vector2 = Vector2(0,0)
	var maxLength: float
	var velocity: Vector2 = (currentPosition - oldPosition)*.98
	var par: Node2D
	#Updates velocity every frame by verlet integration
	func updateVel(newVelocity: Vector2 = Vector2(0,0)):
		if newVelocity == Vector2(0,0):
			velocity = (currentPosition - oldPosition) * .9
		else:
			velocity = newVelocity
	#Adds velocity, shoots collision ray
	func update():
		newPosition = currentPosition + velocity
		oldPosition = currentPosition
		newPosition = currentPosition + velocity
		currentPosition = newPosition
		
	#Takes neighbor and moves the correct distance away
	func fix(neighbor: Point):
		var delta: Vector2 = neighbor.currentPosition - currentPosition
		if delta.length() == 0:
			return
		var distance = delta.length()
		
		var error = distance - maxLength
		
		currentPosition += delta.normalized() * error * .5 
		neighbor.currentPosition -= delta.normalized() * error * .5 
	
	func collide(neighbor: Point):
		
		
		var space = par.get_world_2d().direct_space_state
		var ray = PhysicsRayQueryParameters2D.create(currentPosition, neighbor.currentPosition)
		ray.collide_with_bodies = true
		
		var result = space.intersect_ray(ray)
		
		if result:
			var normal = result.normal
			var fix = normal 
			var collider = result.collider
			
			if collider is PhysicsObject && collider.attached:
				return
			
			currentPosition += fix
			oldPosition = currentPosition
			neighbor.currentPosition += fix
			neighbor.oldPosition = neighbor.currentPosition
			
			
			
			if collider is PhysicsObject:
				
				var segment: Vector2 = neighbor.currentPosition - currentPosition
				var pushFix = Vector2(segment.y, -segment.x).normalized()
				var difference = collider.global_position - (currentPosition + neighbor.currentPosition) / 2
				
				var fix1 = Vector2(pushFix.x/abs(pushFix.x), pushFix.y/abs(pushFix.y))
				var dif1 = Vector2(difference.x / abs(difference.x), difference.y / abs(difference.y))
				
				if fix1 == dif1:
					collider.global_position += pushFix
				else:
					collider.global_position -= pushFix
			
			
		
		
	
	#just moves to the correct position
	func lastFix(origin: Vector2):
		var distance = currentPosition - origin
		var angle = distance.normalized()
		currentPosition = ((angle) * maxLength) + origin
		

var pointArray: Array[Point] = []

var linePoints: Array[Vector2] =[]

#Initiallizes array of points
func _ready() -> void:
	for i in 10:
		var newPoint: Point = Point.new()
		newPoint.maxLength = max
		newPoint.par = self
		pointArray.append(newPoint)
		


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		updateArray(pointArray.size() - 1)
		pointArray[pointArray.size()-1].currentPosition = pointArray[pointArray.size()-9].currentPosition
	else:
		updateArray()
	
	fixArray()
	linePoints.clear()
	for point in pointArray:
		linePoints.append(point.currentPosition)
	$Grapple.global_position = pointArray[-1].currentPosition
	
	var dif: Vector2 = (pointArray[-1].currentPosition - pointArray[-2].currentPosition).normalized()
	var rot = rad_to_deg(dif.angle())
	
	$Grapple.rotation_degrees = rot
	
	$Line2D.points = linePoints

	
	
func updateArray(index: int = -1):
	var first = true
	var neighbor = Vector2(0,0)
	for i in pointArray.size():

		var point = pointArray.get(i)
		point.maxLength = max
		if first:
			point.currentPosition = get_global_mouse_position()
		elif i == index:
			point.updateVel(Vector2(1000, 1))
			point.update()
		else:
			point.neighbor = neighbor
			point.updateVel()
			point.update()
		first = false
		neighbor = point

func fixArray():

	
	for loop in range(3):
		for i in pointArray.size():
			if i == pointArray.size() - 1:
				pointArray.get(i).lastFix(pointArray.get(i-1).currentPosition)
			#elif i == 0:
				#pass
			else:
				pointArray.get(i).fix(pointArray.get(i+1))
				pointArray.get(i).collide(pointArray.get(i+1))
		for i in range(pointArray.size()-1):
			var p = pointArray.get(i)
			var n = pointArray.get(i+1)
			
			p.collide(n)
			
