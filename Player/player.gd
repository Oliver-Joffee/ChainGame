extends CharacterBody2D

var dir: Vector2

@export var speed: float = 1000

func _ready() -> void:
	Globals.Player = self

func _physics_process(delta: float) -> void:
	dir = Input.get_vector("left", "right", "up", "down")
	velocity = dir * speed
	move_and_slide()
