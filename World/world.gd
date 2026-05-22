extends Node2D
class_name World

func swapToScene(scenePath: String, dir: String):
	for child in get_children():
		if !(child is Player):
			child.queue_free()
	
	var level: PackedScene = load(scenePath)
	var newLevel: Level = level.instantiate()
	newLevel.enter = dir
	add_child(newLevel)
	
	
