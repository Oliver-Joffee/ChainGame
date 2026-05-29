extends Area2D
class_name Powerup

@export var cost: int
@export var powerName: String
@export var desc: String
var pickable: bool = false

var part = load("res://Powerups/pickup_part.tscn")

var orig: String = ""

func _ready() -> void:
	cost = int(cost/Globals.cost)
	orig = powerName + ": " + desc + " " + str(cost) + " gold."
	$CenterContainer/Label.text = orig
	body_entered.connect(entered)
	body_exited.connect(exit)
	var timer: Timer = $Timer
	timer.timeout.connect(reset)

func power(player: Player):
	pass

func _input(event: InputEvent) -> void:
	if pickable:
		if Input.is_action_just_pressed("pickup"):
			if Globals.Player.gold >= cost:
				Globals.Player.gold -= cost
				$CPUParticles2D.emitting = true
				var new = part.instantiate()
				get_parent().add_child(new)
				new.global_position = global_position
				new.emitting = true
				power(Globals.Player)
				queue_free()
			else:
				$CenterContainer/Label.text = "Not enough gold."
				$Timer.start()

func entered(body: Node2D) -> void:
	if body is Player:
		pickable = true
		$CenterContainer/Label.visible = true

func exit(body: Node2D) -> void:
	if body is Player:
		pickable = false
		$CenterContainer/Label.visible = false

func reset():
	$CenterContainer/Label.text = orig
