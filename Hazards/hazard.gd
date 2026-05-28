extends Area2D
class_name Hazard

@export var selfCalling: bool = true
@export var spr: Sprite2D
@export var text: Texture


func effect(body):
	pass

func _ready() -> void:
	spr.texture = text
	if !selfCalling:
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
