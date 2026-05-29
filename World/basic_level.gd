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
		rightGate.free()
		player.global_position = Vector2(1727 - 160, 0)
		
	elif enter == "left":
		leftGate.free()
		player.global_position = Vector2(-1727 + 160 , 0)
		
	elif enter == "up":
		upGate.free()
		player.global_position = Vector2(0, -800)
		
	elif enter == "down":
		downGate.free()
		player.global_position = Vector2(0, 800)
		
	if shop:
		await get_tree().physics_frame
		await get_tree().physics_frame
		for i in get_children():
			if i is Gate:
				i.open()
	
	if Globals.fragile:
		for i in get_tree().get_nodes_in_group("Enemy"):
			i.health = int(i.health / 2)

func checkForEnemies(exception: Enemy = null) -> bool:

	for body in area.get_overlapping_bodies():
		if body is Enemy && body != exception:
			return true
	completed.emit()
	for obj in get_tree().get_nodes_in_group("pushables"):
		obj.specVel = Vector2.ZERO
	return false


func killVel():
	for thing in area.get_overlapping_areas():
		if thing is PhysicsObject:
			thing.oldPosition = thing.global_position
