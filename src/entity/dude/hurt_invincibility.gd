extends Node
onready var hurtbox: Area2D = $"%hurtbox"
onready var hurt_animation: AnimationPlayer = $"%hurt_animation"

var active = false
func trigger():
	hurtbox.make_invulnerable()
	active = true
	yield(hurt_animation, "animation_finished")
	hurtbox.make_vulnerable()
	active = false
