extends Area2D
class_name Gate

@export var level : Level 

enum DIRECTIONS {Left, Right, Up, Down}

var newEnter

var used: bool = false

@export var dir = DIRECTIONS.Left

var newLevel = Globals.levels.pick_random()

func open():
	$AnimatedSprite2D.play("open")
	monitoring = true

func _ready() -> void:

	newLevel = Globals.levels.pick_random()
	if !level.completed.is_connected(open):
		level.completed.connect(open)

func _on_body_entered(body: Node2D) -> void:

	newLevel = Globals.levels.pick_random()

	if body is Player:
		
		if used:
			return
		used = true
		
		if (Globals.levelCount % 3 == 0):
			newLevel = "res://World/shop.tscn"
		if body is Player:
			if dir == DIRECTIONS.Left:
				newEnter = "right"
			elif dir == DIRECTIONS.Right:
				newEnter = "left"
			elif dir == DIRECTIONS.Up:
				newEnter = "down"
			elif dir == DIRECTIONS.Down:
				newEnter = "up"
			
			var root: World = get_tree().current_scene
		
			root.swapToScene(newLevel, newEnter)
