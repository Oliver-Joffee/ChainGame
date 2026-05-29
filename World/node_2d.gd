extends Node2D

var shopItem: PackedScene
var items = Globals.items
var gap: float = 400
var potUp: String = Globals.powerUp.pick_random()

func _ready() -> void:
	
	if randi_range(0,1) == 1:
		shopItem = load("res://World/Shop/shop_item.tscn")
	else:
		shopItem = load(potUp)
	
	#if Globals.shopNum % 2 ==1:
	
	var space = -((Globals.shopNum - 1) / 2) * gap
	for i in Globals.shopNum:
		var newItem = shopItem.instantiate()
		add_child(newItem)
		newItem.global_position = Vector2(space, 0) 
		space += gap
		if newItem is ShopItem:
			pass
		if newItem is Powerup:
			shopItem = load(Globals.powerUp.pick_random())
		
