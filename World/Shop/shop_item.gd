extends Area2D
class_name ShopItem

var possibles = Globals.items
var chosen = Globals.items.pick_random()

var buyable: bool = false

var itemPath: PackedScene = load(chosen)
var item: PhysicsObject = itemPath.instantiate()

var cost = item.price
var orig = item.objectName + " " + item.desc + " " + str(cost) + " Gold. Press E to buy."



func _ready() -> void:
	cost = int(cost / Globals.cost)
	$Sprite2D.texture = item.texture
	$CenterContainer/Label.text = item.objectName + " " + item.desc + " " + str(cost) + " Gold. Press E to buy."
	body_entered.connect(enterExit)
	body_exited.connect(enterExit)

func enterExit(body: CollisionObject2D):
	if body is Player:
		buyable = !buyable
		$CenterContainer/Label.visible = !$CenterContainer/Label.visible

func buy():
	if Globals.Player.gold < cost:
		$CenterContainer/Label.text = "Not enough money."
		$Timer.start(1)
	else:
		Globals.Player.gold -= cost
		get_parent().add_child(item)
		item.global_position = global_position
		item.oldPosition = global_position
		queue_free()



func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pickup"):
		if buyable:
			buy()

func _on_timer_timeout() -> void:
	$CenterContainer/Label.text = orig
