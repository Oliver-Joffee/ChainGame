extends Area2D
class_name Hazard

func effect(body):
	pass

func _ready() -> void:
	area_entered.connect(effect)
	area_exited.connect(exitEffect)
	
	print(get_overlapping_areas())
	
	for i in get_overlapping_areas():
		print("yoooo")
		print(i)
		if i.get_script() == self.get_script():
			queue_free()

func exitEffect(body):
	pass

func onEnter(body):
	
	if body is PhysicsObject:
		effect(body)

func onExit(body):
	if body is PhysicsObject:
		exitEffect(body)
