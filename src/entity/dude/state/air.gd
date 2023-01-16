extends CharacterState
onready var ledge_grab: Node2D = $"../../pivot/ledge_grab"

func _physics_update(delta):
	if root.in_water:
		goto("swim_idle")
		return
	
	if root.is_on_floor():
		goto("idle")
		return
	
	var ledge = ledge_grab.get_ledge()
	if ledge != null:
		goto_args("ledge_up",[ledge])
		return
