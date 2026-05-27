extends Node2D
class_name World

var levelCount: int = 1


func swapToScene(scenePath: String, dir: String):
	
	Globals.Player.clear()
	levelCount += 1
	for child in get_children():
		if !(child is Player):
			child.queue_free()
	
	
	var level: PackedScene = load(scenePath)
	var newLevel: Level = level.instantiate()
	newLevel.enemyScale = levelCount
	newLevel.enter = dir
	add_child(newLevel)
	
	
