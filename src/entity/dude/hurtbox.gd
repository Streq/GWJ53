extends Area2D
signal hurt()
onready var health: Node = $"%health"

export var invulnerability_counter = 0

func get_hurt(hitbox):
	if invulnerability_counter > 0:
		return
	take_damage(hitbox.damage)
	hitbox.register_hit()

func take_damage(amount):
	health.take_damage(amount)
	emit_signal("hurt")

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
