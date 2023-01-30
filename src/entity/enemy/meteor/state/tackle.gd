extends CharacterState
signal tackle_wall
onready var duration: Timer = $duration
var done = false

var previous_damping = 0.0
var previous_air_damping = 0.0

func _ready() -> void:
	duration.connect("timeout",self,"finish")
	
func _enter(params):
#	root.velocity += 1000*root.input_state.dir
	print(root.input_state)
	root.velocity = 500*root.input_state.dir
	duration.start()
	done = false
	previous_damping = root.damping
	previous_air_damping = root.air_damping
	root.damping = 0.0
	root.air_damping = 0.0
var previous_velocity := Vector2()
func _physics_update(delta:float) -> void:
	if done:
		goto(on_finish_goto_state)
		return
	
	var body : KinematicBody2D = root
	
	var collision_count = body.get_slide_count()
	
	if collision_count:
		var normal = Vector2()
		
		for i in collision_count:
			var collision = body.get_slide_collision(i)
			normal += collision.normal
		
		normal = normal.normalized()
		
		body.velocity = previous_velocity.bounce(normal)*0.2
		Shake.shake(normal)
		emit_signal("tackle_wall")
		goto("stun")
		return
	previous_velocity = body.velocity
	
func _exit() -> void:
	duration.stop()
	
	root.damping = previous_damping
	root.air_damping = previous_air_damping

func finish():
	done = true
	
