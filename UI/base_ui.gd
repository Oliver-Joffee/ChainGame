extends Control

func _process(delta: float) -> void:
	$Label.text = "Gold: " + str(Globals.Player.gold)
