extends Area2D
class_name ShopItem

var possibles = Globals.items
var chosen = Globals.items.pick_random()

var buyable: bool = false

var itemPath: PackedScene = load(chosen)
var item: PhysicsObject = itemPath.instantiate()

var orig = item.objectName + " " + item.desc + " " + str(item.price) + " Gold. Press E to buy."

func _ready() -> void:
	$Sprite2D.texture = item.texture
	$Label.text = item.objectName + " " + item.desc + " " + str(item.price) + " Gold. Press E to buy."
	body_entered.connect(enterExit)
	body_exited.connect(enterExit)

func enterExit(body: CollisionObject2D):
	if body is Player:
		buyable = !buyable
		$Label.visible = !$Label.visible

func buy():
	if Globals.Player.gold < item.price:
		$Label.text = "Not enough money."
		$Timer.start(1)
	else:
		Globals.Player.gold -= item.price
		get_parent().add_child(item)
		item.global_position = global_position
		item.oldPosition = global_position
		queue_free()



func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pickup"):
		buy()


func _on_timer_timeout() -> void:
	$Label.text = orig
