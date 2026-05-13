extends CharacterBody2D
class_name Player

enum STATES {NORMAL, STUNNED}
var state: STATES = STATES.NORMAL

var inventory: Array[PhysicsObject] = []

var gold: int = 0

var dir: Vector2
var velOffset: Vector2 = Vector2(0,0)
var velOverride: float = 1

var health: float = 100

@export var speed: float = 1000
@export var chain: Chain

func stun():
	state = STATES.STUNNED

func dash():
	velOffset += dir * 5000

func _ready() -> void:
	Globals.Player = self
	
func damage(damage: float):
	health -= damage
	
func knockback(source: Vector2, force: float):

	velOffset += (global_position - source).normalized() * force

func _physics_process(delta: float) -> void:

	
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
