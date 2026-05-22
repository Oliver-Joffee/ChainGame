extends HBoxContainer

var boxObject: PhysicsObject

func create(object: PhysicsObject):
	$Label.text = object.name + ": " + object.desc
	$TextureButton.texture_normal = object.texture
	boxObject = object


func _on_texture_button_button_up() -> void:
	Globals.Player.spawn(boxObject)
	queue_free()
