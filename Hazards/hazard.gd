extends Area2D
class_name Hazard

func effect(body):
	pass

func _ready() -> void:
	area_entered.connect(effect)
	area_exited.connect(exitEffect)

func exitEffect(body):
	pass

func onEnter(body):
	effect(body)

func onExit(body):
	exitEffect(body)
