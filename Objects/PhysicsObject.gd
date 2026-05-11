extends RigidBody2D
class_name PhysicsObject

var velocity: Vector2
var oldPosition: Vector2
var attached: bool = false
var attachable: bool = true
var specVel: Vector2 = Vector2(0,0)

@export var weight: float
@export var friction: float
@export var hitbox: Area2D

func detach():
	attached = false
	attachable = false
	var enemies: Array = get_enemies()
	var enemyAngles: Array[float]
	var velAngle = velocity.angle()
	var closestAngle: float
	print(enemies.size())
	for i in enemies:
		enemyAngles.append((enemies[i].global_position - global_position).angle())
	
	for i in enemyAngles:
		if i == 1:
			closestAngle = enemyAngles[i]
		else:
			if abs(enemyAngles[i] - velAngle) < abs(closestAngle - velAngle):
				closestAngle = enemyAngles[i]
	
	if enemies.size() > 1:
		specVel = Vector2.from_angle(closestAngle) * velocity.length()
	
	await get_tree().create_timer(.5).timeout
	attachable = true

func _ready() -> void:
	
	oldPosition = global_position
	hitbox.body_entered.connect(collide)

func get_enemies() -> Array:
	return get_tree().get_nodes_in_group("Damagables")

func _physics_process(delta: float) -> void:
	update()

func collide(body):
	print("yay")
	print(body)
	
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
	
