extends CharacterState

signal step()
onready var ledge_grab: Node2D = $"%ledge_grab"

var stamp = 0

#malisimo pero funca
func _enter(params):
	stamp += 1
	var current_stamp = stamp
	var ledge : Vector2 = params[0]
	root.velocity = Vector2()
	var movement_against_ledge = Vector2(root.facing_dir,0)*8.0
	var is_branch = root.move_and_collide(
			movement_against_ledge,
			true,
			true,
			true
		) == null
	if !is_branch:
		root.move_and_collide(movement_against_ledge)
	root.global_position.y = ledge.y
#	print(root.global_position)
	for i in 4:
		yield(self,"step")
		if current_stamp != stamp:
			return
		root.global_position.y -= 1.0
#		print(root.global_position)
	for i in 5:
		yield(self,"step")
		if current_stamp != stamp:
			return
		if !is_branch:
			root.global_position.x += root.facing_dir
#		print(root.global_position)
		
	if !ledge_grab.can_stand():
		root.velocity += Vector2(root.facing_dir*15,-5)
	goto("air")

		

func _physics_update(delta):
	root.velocity = Vector2()

func step():
	emit_signal("step")
