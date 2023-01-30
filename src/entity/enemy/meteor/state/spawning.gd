extends CharacterState

onready var warmup: Timer = $warmup
onready var eye_spawner: Node2D = $"%eye_spawner"

var ready_to_spawn = false

func _ready() -> void:
	warmup.connect("timeout",self,"_on_warmup_timeout")

func _enter(params):
	warmup.start()
	ready_to_spawn = false
	root.velocity = Vector2()
func _exit():
	warmup.stop()
	eye_spawner.stop()

func _physics_update(delta: float) -> void:
	if ready_to_spawn:
		eye_spawner.spawn()
		goto("idle")
		

func _on_warmup_timeout():
	ready_to_spawn = true
