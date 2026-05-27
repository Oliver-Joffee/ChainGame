extends Area2D
class_name Hazard

func effect(body):
	pass

func _ready() -> void:
	area_entered.connect(onEnter)
	area_exited.connect(onExit)
	

			
	

func exitEffect(body):
	pass

func onEnter(body):

	
	if body is PhysicsObject:
		effect(body)

func onExit(body):
	if body is PhysicsObject:
		exitEffect(body)
