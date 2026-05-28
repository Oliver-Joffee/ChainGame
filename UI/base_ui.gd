extends Control

func _process(delta: float) -> void:
	$Label.text = "Gold: " + str(Globals.Player.gold)
	$Label2.text = "Health: " + str(Globals.Player.health) + " / " + str(Globals.Player.maxHealth)
	$Label3.text = "Stage: " + str(Globals.levelCount)
