extends CharacterBody2D
class_name PhysicsObject

var velocity: Vector2
var oldPosition: Vector2
var attached: bool = false

@export var weight: float
@export var friction: float
@export var hitbox: Area2D

func _ready() -> void:
	oldPosition = global_position
	hitbox.body_entered.connect(collide)
	

func _physics_process(delta: float) -> void:
	update()
func collide(body):
	print("yay")
	print(body)
	
func update():
	if !attached:
		velocity = (global_position - oldPosition) * friction
	
	if velocity.length() < 1:
		velocity = Vector2(0,0)
	
	oldPosition = global_position
	global_position += velocity
	
