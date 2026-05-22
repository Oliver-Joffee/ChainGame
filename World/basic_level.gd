extends TileMapLayer
class_name Level

signal completed

@onready var player = Globals.Player

@onready var area = $Area2D

@export var leftGate: Gate
@export var rightGate: Gate
@export var downGate: Gate
@export var upGate: Gate

var enter: String = "right"

func _ready() -> void:
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

func checkForEnemies() -> bool:
	for body in area.get_overlapping_bodies():
		if body is Enemy:
			completed.emit()
			return true
	return false
