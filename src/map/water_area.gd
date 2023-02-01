extends Area2D

func _on_water_area_body_entered(body: Node) -> void:
	body.in_water = true
	if "global_position" in body and "velocity" in body:
		var splash :CPUParticles2D= ParticlePool.play("splash",body.global_position)
		splash.global_rotation = (-body.velocity).angle()
		splash.amount = int(body.velocity.length())/10
func _on_water_area_body_exited(body: Node) -> void:
	body.in_water = false
