extends Control
class_name Inventory

const ELEMENT = preload("res://UI/inventory_element.tscn")
@onready var vBox = %VBoxContainer
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("showInven"):
		if visible:
			hideInventory()
		else:
			showInventory()
	
	if visible:
		if Input.is_action_just_pressed("leftClick"):
			hide

func showInventory():
	get_tree().paused = true
	update()
	visible = true
	
func hideInventory():
	get_tree().paused = false
	visible = false

func update():
	for i in vBox.get_children():
		i.queue_free()
	
	for obj in Globals.Player.inventory:
		var newElement = ELEMENT.instantiate()
		vBox.add_child(newElement)
		newElement.create(obj)
