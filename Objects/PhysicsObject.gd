extends RigidBody2D
class_name PhysicsObject

var velocity: Vector2
var oldPosition: Vector2
var attached: bool = false

func _ready() -> void:
	oldPosition = global_position

func _physics_process(delta: float) -> void:
	update()

	
func update():
	velocity = (global_position - oldPosition) * .9
	
	oldPosition = global_position
	global_position += velocity
	
