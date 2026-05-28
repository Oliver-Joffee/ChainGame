extends Area2D
class_name PhysicsObject

var frozen: bool = false

@export var texture: Texture
@export var sprite: Sprite2D
@export var objectName: String
@export var label: Label
@export var desc: String
@export var price: int = 3

var pickingUp: bool = false
var velocity: Vector2
var oldPosition: Vector2
var attached: bool = false
var attachable: bool = true
var specVel: Vector2 = Vector2.INF

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
		if abs(rad_to_deg(closestAngle) - rad_to_deg(velAngle)) < 90:
			specVel = Vector2.from_angle(closestAngle) * velocity.length()
	
	await get_tree().create_timer(.5).timeout
	attachable = true

func pickup():
	if attached:
		$ObjectLabel.change("Release the chain first.")
		return
	if Globals.Player.inventory.size() >= Globals.Player.inventorySpace:
		$ObjectLabel.change("Inventory full.")
		return
	detach()
	Globals.Player.inventory.append(self)
	get_parent().remove_child(self)

func _ready() -> void:
	z_as_relative = false
	label.text = objectName + " Press E to pick up"
	label.orig = objectName + " Press E to pick up"
	sprite.texture = texture
	friction = originalFriction
	body_entered.connect(collide)
	oldPosition = global_position
	add_to_group("pushables")

func get_enemies() -> Array:
	return get_tree().get_nodes_in_group("Damageable")

func _physics_process(delta: float) -> void:
	if pickingUp:
		label.visible = true
	else:
		label.visible = false
	update(delta)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pickup"):
		if pickingUp:
			pickup()

func collide(body):
	if attached:
		Globals.grapple.enter.emit()
		return
	
	if body is Enemy && !attached:
		damageBody(body)

func damageBody(body: Enemy):
	body.damage(weight * velocity.length(), global_position, weight * velocity.length() * 20)

func attach():
	attached = true
	#set_collision_mask_value(1, false)
	
	
func update(delta: float):
	friction = originalFriction
	for i in get_overlapping_areas():
		if i is Hazard:
			if i.selfCalling:
				i.effect(self)
	
	if !attached:
		velocity = (global_position - oldPosition) * pow(friction, delta * 60)
	
	if specVel != Vector2.INF:
		velocity = specVel
		specVel = Vector2.INF
	if velocity.length() < 1:
		velocity = Vector2(0,0)
	
	if velocity.length() > 0 && !attached:
		var space = get_world_2d().direct_space_state
		var ray = PhysicsRayQueryParameters2D.create(global_position, global_position + velocity * 2)
		ray.collide_with_bodies = true
		ray.exclude = [self]
		#ray.hit_from_inside = true
		var result = space.intersect_ray(ray)
		if result:
			var normal = result.normal
			if normal == Vector2.ZERO:
				specVel = -velocity
			else:
				bounceSpecVel(normal)
	oldPosition = global_position
	global_position += velocity

func bounceSpecVel(normal: Vector2):
	specVel = velocity.bounce(normal)
