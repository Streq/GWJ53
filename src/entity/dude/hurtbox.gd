extends Area2D
signal hurt()
onready var health: Node = $"%health"

export var invulnerability_counter = 0

func get_hurt(hitbox):
	if invulnerability_counter > 0:
		return
	health.take_damage(hitbox.damage)
	emit_signal("hurt")
	hitbox.register_hit()

func get_team():
	return owner.team

func make_invulnerable():
	invulnerability_counter += 1
	pass

func make_vulnerable():
	invulnerability_counter -= 1
	if invulnerability_counter > 0:
		return
	if invulnerability_counter < 0:
		printerr("invulnerability_counter reached ",invulnerability_counter,", make_invulnerable and make_vulnerable should be called in pairs")
