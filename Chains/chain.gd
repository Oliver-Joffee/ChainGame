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
		var ray = RayCast2D.new()
		
		ray.global_position = currentPosition
		ray.target_position = newPosition - ray.global_position
		ray.enabled = true
		ray.hit_from_inside = true
		par.add_child(ray)
		ray.force_raycast_update()
		if ray.is_colliding():
			var normal = ray.get_collision_normal().normalized()
			currentPosition = ray.get_collision_point() + normal
		else:
			currentPosition = newPosition
		par.remove_child(ray)
		
	#Takes neighbor and moves the correct distance away
	func fix(neighbor: Point):
		var delta: Vector2 = neighbor.currentPosition - currentPosition
		if delta.length() == 0:
			return
		var distance = delta.length()
		
		var error = distance - maxLength
		
		currentPosition += delta.normalized() * error * .5 
		neighbor.currentPosition -= delta.normalized() * error * .5 
	
	
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
	if Input.is_action_just_pressed("ui_accept"):
		updateArray(pointArray.size()-1)
	else:
		updateArray()
	
	fixArray()
	linePoints.clear()
	for point in pointArray:
		linePoints.append(point.currentPosition)
	$Line2D.points = linePoints

	
	
func updateArray(index: int = -1):
	var first = true
	var neighbor = Vector2(0,0)
	for i in pointArray.size():

		var point = pointArray.get(i)
		if first:
			point.currentPosition = get_global_mouse_position()
		elif i == index:
			point.updateVel(Vector2(1000, 0))
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
