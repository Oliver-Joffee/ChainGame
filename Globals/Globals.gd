extends Node

var grapple: Grapple

var Player: Player

var levelCount: int = 1

var items: Array[String] = ["res://Objects/icy_object.tscn",
"res://Objects/sliding_object.tscn",
"res://Objects/test_physics.tscn",
"res://Objects/boomerang.tscn",
"res://Objects/BouncyObject.tscn",
"res://Objects/homing.tscn",
"res://Objects/rocket.tscn",
"res://Objects/spike.tscn",
"res://Objects/wind.tscn",
"res://Objects/plane.tscn"
]

var levels: Array[String] = ["res://World/test_level.tscn"]

var shopNum: float = 3

var powerUp: Array[String] = ["res://Powerups/speed_up.tscn",
"res://Powerups/health_refill.tscn",
"res://Powerups/inventory_up.tscn",
"res://Powerups/max_health_up.tscn",
"res://Powerups/shop_up.tscn",
]

var fragile: bool = false
var many: bool = false
var manyNum: int = 1
var cost: int = 1

func _ready() -> void:
	randomize()
