extends CharacterBody2D
class_name Enemy
var velOffset: Vector2 = Vector2(0,0)

var gold: PackedScene = load("res://Gold/gold.tscn")

@onready var player = Globals.Player
@export var health: float = 500
@export var distToKill: float
@export var damBox: Area2D

func gameover():
	var newGold = gold.instantiate()
	get_parent().add_child(newGold)
	newGold.global_position = global_position
	queue_free()
	var level: Level = get_parent()
	level.checkForEnemies()

func _ready() -> void:
	damBox.body_entered.connect(attack)

func damage(damage: float, colPosition: Vector2):
	
	print("damage" + str(damage))
	velOffset += (global_position - colPosition).normalized() * 1000
	health -= round(damage)
	if health <= 0:
		gameover()

func attack(thing):
	if thing is Player:
		thing.damage(0)
		thing.knockback(global_position, 2000)
		thing.stun()

func _process(delta: float) -> void:
	var target = player.global_position
	$Area2D.look_at(target)
	velocity = (target - global_position).normalized() * 500 + velOffset
	velOffset *= .9
	move_and_slide()
