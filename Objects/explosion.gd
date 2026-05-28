extends Area2D

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	explode()

func explode():
	$CPUParticles2D.emitting = true
	for i in get_overlapping_bodies():
		print("bodt")
		if i is Enemy:
			print("enemy")
			i.damage(30, global_position, 10000)
			


func _on_cpu_particles_2d_finished() -> void:
	queue_free()
