extends TileMapLayer
class_name Level

signal completed

var enemyScale: float = 1

@onready var player = Globals.Player

@onready var area = $Area2D

@export var leftGate: Gate
@export var rightGate: Gate
@export var downGate: Gate
@export var upGate: Gate
@export var shop: bool = false

var enter: String = "right"

func _ready() -> void:
	
	for i in get_children():
		if i is Enemy:
			i.scale(enemyScale)
	
	if enter == "right":
		player.global_position = Vector2(1727, 0)
		rightGate.queue_free()
	elif enter == "left":
		player.global_position = Vector2(-1727, 0)
		leftGate.queue_free()
	elif enter == "up":
		player.global_position = Vector2(0, -960)
		upGate.queue_free()
	elif enter == "down":
		player.global_position = Vector2(0, 960)
		downGate.queue_free()
		
	if shop:
		call_deferred("checkForEnemies")

func checkForEnemies() -> bool:
	print("happened")
	for body in area.get_overlapping_bodies():
		print("body")
		if body is Enemy:
			completed.emit()
			return true
	completed.emit()
	return false


func killVel():
	for thing in area.get_overlapping_areas():
		if thing is PhysicsObject:
			thing.oldPosition = thing.global_position
