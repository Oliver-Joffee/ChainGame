extends Label
class_name Notice

var orig: String

func _ready() -> void:
	orig = text

func change(newText: String, time: int = 1):
	text = newText
	$Timer.start(3)

func _physics_process(delta: float) -> void:
	rotation_degrees = -get_parent().rotation_degrees
	global_position = Vector2(get_parent().global_position.x - size.x / 2, get_parent().global_position.y - 128)


func _on_timer_timeout() -> void:
	text = orig
