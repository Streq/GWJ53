extends Node2D

export var enabled := true setget set_enabled

func set_enabled(val):
	if enabled != val:
		return
	enabled = val
	set_physics_process(enabled)

enum {
	SPAWN,
	SHOOT,
	TACKLE,
	CHASE,
	DRAIN
	NOTHING,
}

var chances = [
	{
		"min_health": 0.75,
		"idle_time": 3.0,
		"attacks": {
			SPAWN: 0.3,
			SHOOT: 0.7
		}
	},
	{
		"min_health": 0.5,
		"idle_time": 2.0,
		"attacks": {
			SPAWN: 0.25,
			SHOOT: 0.35,
			TACKLE: 0.35
		}
	},
	{
		"min_health": 0.0,
		"idle_time": 0.0,
		"attacks": {
			DRAIN: 1.0
		},
		"once":true
	},
	{
		"min_health": 0.25,
		"idle_time": 2.0,
		"attacks": {
			SPAWN: 0.25,
			SHOOT: 0.35,
			TACKLE: 0.5,
			CHASE: 0.5
		}
	},
	{
		"min_health": 0.0,
		"idle_time": 1.0,
		"attacks": {
#			SPAWN: 0.0,
#			SHOOT: 0.0,
			TACKLE: 0.35,
			CHASE: 0.35
		}
	}

]



var time := 0.0
var state = NOTHING setget set_state

onready var health = owner.get_node("health")
func set_state(val):
	state = val
	time = 0.0

var idle_time := 3.0

func _physics_process(delta: float) -> void:
	var player = Group.get_one("player")
	if !player:
		return
	
	owner.input_state.clear()
	owner.input_state.dir = player.global_position-owner.global_position
	
	var current_machine_state = owner.state_machine.current.name
	
	match state:
		SPAWN:
			owner.input_state.A.pressed = !owner.input_state.A.pressed
		TACKLE:
			owner.input_state.B.pressed = !owner.input_state.B.pressed
		CHASE:
			owner.input_state.L.pressed = !owner.input_state.L.pressed
		SHOOT:
			owner.input_state.R.pressed = !owner.input_state.R.pressed
		DRAIN:
			owner.input_state.A.pressed = !owner.input_state.A.pressed
			owner.input_state.B.pressed = !owner.input_state.B.pressed
		NOTHING:
			if time > idle_time:
				for config_index in chances.size():
					var config = chances[config_index]
					if config.min_health <= health.bar.value/health.bar.max_value:
						if config.has("once"):
							print(owner.input_state)
							chances.remove(config_index)
						
						var odds = config.attacks
						idle_time = config.idle_time
						var index = Random.choose_weighted(odds.values())
						self.state = odds.keys()[index]
						break
	
	if current_machine_state == "idle":
		time += delta
	else:
		self.state = NOTHING
	
#	print(owner.input_state.B.pressed)
