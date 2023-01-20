extends Node
onready var hurtbox: Area2D = $"%hurtbox"
onready var hurt_animation: AnimationPlayer = $"%hurt_animation"


func trigger():
	hurtbox.make_invulnerable()
	yield(hurt_animation, "animation_finished")
	hurtbox.make_vulnerable()
