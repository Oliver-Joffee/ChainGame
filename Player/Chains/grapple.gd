extends Area2D
class_name Grapple

signal enter

class object:
	var physic: PhysicsObject
	var relative: Vector2
	var startRot: float

var objects: Array[object]

@onready var chain: Chain = get_parent()

func _ready() -> void:
	enter.connect(chain.switch)
	Globals.grapple = self

func objectIn(object: PhysicsObject) -> bool:
	for i in objects:
		if i.physic == object:
			return true
			
	return false

#func _on_body_entered(body: Node2D) -> void:
	#enter.emit()
		
func clear():
	print("cleared")
	for i in objects:
		i.physic.detach()
	objects.clear()
		
func _physics_process(delta: float) -> void:
	
	
	
	for o in objects:
		$Marker2D.position = o.relative
		#o.physic.global_position = to_global($Marker2D.position)
		o.physic.velocity = to_global($Marker2D.position) - o.physic.global_position
		o.physic.rotation_degrees = rotation_degrees + o.startRot


func _on_area_entered(area: Area2D) -> void:
	
	if objects.size() == 0:
		if area is PhysicsObject:
			if !objectIn(area) && area.attachable:
				var newObject = object.new()
				
				newObject.physic = area
				newObject.physic.attach()
				newObject.startRot = area.rotation_degrees
				newObject.relative = to_local(area.global_position)
				
				objects.append(newObject)
