extends Area2D

func _on_water_area_body_entered(body: Node) -> void:
	body.in_water = true
	if "global_position" in body and "velocity" in body:
		var particle_count = int(body.velocity.length())/10
		if !particle_count:
			return
		var splash :CPUParticles2D= ParticlePool.play("splash",body.global_position)
		if is_instance_valid(splash):
			splash.global_rotation = (-body.velocity).angle()
			splash.amount = particle_count

func _on_water_area_body_exited(body: Node) -> void:
	body.in_water = false
