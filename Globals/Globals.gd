extends Node

var grapple: Grapple

var Player: Player

var items: Array[String] = ["res://Objects/icy_object.tscn",
"res://Objects/sliding_object.tscn",
"res://Objects/test_physics.tscn"]

var levels: Array[String] = ["res://World/test_level.tscn",
"res://World/obstacles.tscn"]

var shopNum: float = 3

func _ready() -> void:
	randomize()
