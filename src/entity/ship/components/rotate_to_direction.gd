extends Node

var direction = Vector2.RIGHT
var stored_facing_dir = 1.0
func _physics_process(delta: float) -> void:
	var B_pressed = owner.input_state.B.is_pressed()
	if !B_pressed:
		if owner.input_state.dir:
			direction = owner.input_state.dir
			stored_facing_dir = owner.facing_dir
			direction.x *= stored_facing_dir
	elif owner.facing_dir != stored_facing_dir:
		direction.x *= -1
		stored_facing_dir = owner.facing_dir
	get_parent().rotation = direction.angle()
		
		
#		print(get_parent().rotation_degrees)
