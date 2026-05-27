extends Node2D

var shopItem = load("res://World/Shop/shop_item.tscn")
var items = Globals.items
var gap: float = 400

func _ready() -> void:
	
	print("im a shop")
	#if Globals.shopNum % 2 ==1:
	var space = -((Globals.shopNum - 1) / 2) * gap
	for i in Globals.shopNum:
		var newItem: ShopItem = shopItem.instantiate()
		add_child(newItem)
		newItem.global_position = Vector2(space, 0) 
		space += gap
		
