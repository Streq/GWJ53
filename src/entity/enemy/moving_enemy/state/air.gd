extends CharacterState
onready var hurtbox: Area2D = $"%hurtbox"

func _physics_update(delta):
	if root.in_water:
		root.die()
		return
	
	if root.is_on_floor():
		if root.previous_velocity.y > 90.0:
			hurtbox.take_damage(floor((root.previous_velocity.y-90.0)/30.0)+1.0)
		goto("idle")
		return
