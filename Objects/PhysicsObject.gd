extends Area2D
class_name PhysicsObject

var velocity: Vector2
var oldPosition: Vector2
var attached: bool = false
var attachable: bool = true
var specVel: Vector2 = Vector2(0,0)

var friction: float

@export var weight: float = 1
@export var originalFriction: float = .9

func detach():
	attached = false
	attachable = false
	#set_collision_mask_value(1, true)
	var enemies: Array = get_enemies()
	var enemyAngles: Array[float]
	var velAngle = velocity.angle()
	var closestAngle: float

	for i in range(enemies.size()):
		enemyAngles.append((enemies[i].global_position - global_position).angle())
	
	for i in range(enemyAngles.size()):
		if i == 0:
			closestAngle = enemyAngles[i]
		else:
			if abs(enemyAngles[i] - velAngle) < abs(closestAngle - velAngle):
				closestAngle = enemyAngles[i]
	
	if enemies.size() >= 1:
		if abs(rad_to_deg(closestAngle) - rad_to_deg(velAngle)) < 45:
			specVel = Vector2.from_angle(closestAngle) * velocity.length()
	
	await get_tree().create_timer(.5).timeout
	attachable = true

func _ready() -> void:
	friction = originalFriction
	body_entered.connect(collide)
	oldPosition = global_position


func get_enemies() -> Array:
	return get_tree().get_nodes_in_group("Damageable")

func _physics_process(delta: float) -> void:
	update()

func collide(body):
	if body is Enemy && !attached:
		body.damage(weight * velocity.length(), global_position)
	var space = get_world_2d().direct_space_state
	var ray = PhysicsRayQueryParameters2D.create(oldPosition, (global_position - oldPosition) * 200 + oldPosition)
	ray.collide_with_bodies = true
	ray.hit_from_inside = true
	
	var result = space.intersect_ray(ray)
	
	if result:
		var normal = result.normal
		
		specVel = velocity.bounce(normal)
		
func attach():
	attached = true
	#set_collision_mask_value(1, false)
	
	
func update():
	if !attached:
		velocity = (global_position - oldPosition) * friction
	
	if specVel != Vector2(0,0):
		velocity = specVel
		specVel = Vector2(0,0)
	
	if velocity.length() < 1:
		velocity = Vector2(0,0)
	
	oldPosition = global_position
	global_position += velocity
	
