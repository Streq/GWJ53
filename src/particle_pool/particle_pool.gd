extends CPUParticles2D

export var pool_size := 10

var pool := []
var index := 0

func _ready() -> void:
	setup()

func setup():
	index = 0
	for i in pool_size:
		var instance = duplicate(0)
		pool.append(instance)
	
	for instance in pool:
		add_child(instance)


func refresh():
	for child in pool:
		child.queue_free()
	pool = []
	setup()


func play_at_position(global_pos) -> CPUParticles2D:
	index = (index+1)%pool_size
	
	var particles = pool[index]
	particles.restart()
	particles.global_position = global_pos
	return particles
