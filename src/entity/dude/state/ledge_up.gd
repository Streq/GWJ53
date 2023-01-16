extends CharacterState

signal step()

#malisimo pero funca
func _enter(params):
	var ledge : Vector2 = params[0]
	root.velocity = Vector2()
	root.move_and_collide(Vector2(root.facing_dir,0)*8.0)
	root.global_position.y = ledge.y
	print(root.global_position)
	for i in 4:
		yield(self,"step")
		root.global_position.y -= 1.0
		print(root.global_position)
	for i in 5:
		yield(self,"step")
		root.global_position.x += root.facing_dir
		print(root.global_position)
		
	
	root.velocity += Vector2(root.facing_dir*15,-5)
	goto("air")

func _physics_update(delta):
	root.velocity = Vector2()

func step():
	emit_signal("step")
