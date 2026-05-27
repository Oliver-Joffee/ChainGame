extends Area2D
class_name Gate

@export var level : Level 

enum DIRECTIONS {Left, Right, Up, Down}

var newEnter

@export var dir = DIRECTIONS.Left

var newLevel = Globals.levels.pick_random()

func open():
	print("recieved")
	monitoring = true

func _ready() -> void:
	print("connected")
	newLevel = Globals.levels.pick_random()
	print(newLevel)
	level.completed.connect(open)

func _on_body_entered(body: Node2D) -> void:
	newLevel = Globals.levels.pick_random()
	if (randi_range(0,1) == 0):
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
