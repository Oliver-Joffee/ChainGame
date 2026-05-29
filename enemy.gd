extends CharacterBody2D
class_name Enemy
var velOffset: Vector2 = Vector2(0,0)

var gold: PackedScene = load("res://Gold/gold.tscn")

@export var attackStat: float = 20

var attacking: bool = false

var particle = load("res://Enemies/enemy_particle.tscn")

@onready var player = Globals.Player
@export var health: float = 500
@export var distToKill: float
@export var damBox: Area2D

func scale(specialScale: int):
	var newScale = (float(specialScale-1)/15) + 1

	attackStat *= newScale
	health *= newScale


func gameover():
	var newGold = gold.instantiate()
	get_parent().add_child(newGold)
	newGold.global_position = global_position
	queue_free()
	var level: Level = get_parent()
	level.checkForEnemies(self)


func damage(damage: float, colPosition: Vector2, knockBackStrength: float):
	
	if damage != 0:
		var newPart = particle.instantiate()
		get_parent().add_child(newPart)
		newPart.global_position = global_position
		newPart.rotation_degrees = rad_to_deg((colPosition - global_position).normalized().angle())
		newPart.emitting = true
	velOffset += (global_position - colPosition).normalized() * knockBackStrength
	health -= round(damage)
	if health <= 0:
		gameover()



func start():
	attacking = !attacking
	$Area2D.visible = !$Area2D.visible

func attack(thing):
	if thing is Player:

		thing.damage(attackStat)
		thing.knockback(global_position, 2000)
		thing.stun()

func _process(delta: float) -> void:
	var prev = global_position
	var target = player.global_position
	
	if global_position.distance_to(target) < 192:
		$AnimationPlayer.play("attack")
	
	if !attacking:
		$Area2D.look_at(target)
	
	
	var newVel = (target - global_position).normalized() * 1050
	if attacking:
		newVel = Vector2.ZERO
	
	velocity = newVel + velOffset
	
	velOffset *= .9
	if newVel.x < 0:
		$Sprite2D.play("left")
	elif newVel.x > 0:
		$Sprite2D.play("right")
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	attack(body)
