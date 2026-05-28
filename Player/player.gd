extends CharacterBody2D
class_name Player

enum STATES {NORMAL, STUNNED}
var state: STATES = STATES.NORMAL

var inventory: Array[PhysicsObject] = []

var gold: int = 10

var dir: Vector2
var velOffset: Vector2 = Vector2(0,0)
var velOverride: float = 1

var health: float = 100
var maxHealth: float = 100

@export var speed: float = 1000
@export var chain: Chain

var inventorySpace: int = 3

func checkAnim():
	if Input.is_action_pressed("down"):
		$AnimatedSprite2D.play("back")
	if Input.is_action_pressed("left"):
		$AnimatedSprite2D.play("left")
	if Input.is_action_pressed("up"):
		$AnimatedSprite2D.play("up")
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.play("right")

func stun():
	state = STATES.STUNNED

func dash():
	velOffset += dir * 5000

func _ready() -> void:
	Globals.Player = self
	
func damage(damage: float):
	health -= damage
	if health <= 0:
		gameover()

func gameover():
	get_tree().change_scene_to_file("res://UI/gameover.tscn")

func clear():
	$Chain.grapple.clear()

func knockback(source: Vector2, force: float):

	velOffset += (global_position - source).normalized() * force

func _physics_process(delta: float) -> void:
	for body in $Pickup.get_overlapping_areas():
		if body is PhysicsObject:
			pass
	
	if state == STATES.NORMAL:
		if Input.is_action_just_pressed("dash") && velOverride == 1:
			dash()
		
		dir = Input.get_vector("left", "right", "up", "down")
		velocity = ((dir * speed) + velOffset) * velOverride
	if state == STATES.STUNNED:
		velocity = velOffset
		if velOffset.length() < 500:
			state = STATES.NORMAL
	velOffset *= .9
	if velOffset.length() < 1:
		velOffset = Vector2.ZERO
	move_and_slide()


func _on_pickup_area_entered(area: Area2D) -> void:
	if area is PhysicsObject:
		area.pickingUp = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("down"):
		$AnimatedSprite2D.play("idle")

	if Input.is_action_just_released("up"):
		$AnimatedSprite2D.play("upidle")

	if Input.is_action_just_released("left"):
		$AnimatedSprite2D.play("leftidle")

	if Input.is_action_just_released("right"):
		$AnimatedSprite2D.play("rightidle")

	
	if Input.is_action_pressed("down"):
		$AnimatedSprite2D.play("back")
	if Input.is_action_pressed("left"):
		$AnimatedSprite2D.play("left")
	if Input.is_action_pressed("up"):
		$AnimatedSprite2D.play("up")
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.play("right")
	
	

func spawn(object: PhysicsObject):
	get_parent().add_child(object)
	object.frozen = false
	object.global_position = global_position + Vector2(0, 128)
	object.oldPosition = object.global_position
	inventory.erase(object)

func _on_pickup_area_exited(area: Area2D) -> void:
	if area is PhysicsObject:
		area.pickingUp = false
