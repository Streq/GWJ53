extends Node2D
signal player_pressed_A

onready var player_controller: Node = $"../dude/player_controller"

onready var set_health_to: Node = $"../ship/set_health_to"

export var entered_ship = false
export var ship_health_full = false

export var put_rear = false

export var put_teleport = false 

export var put_up = false

export var put_down = false

export var put_dome = false

export var put_gun = false

export var disabled := false

onready var ship_components_hud: VBoxContainer = $"%ship_components_HUD"
onready var ship: KinematicBody2D = $"%ship"

func _ready() -> void:
	if disabled:
		queue_free()
		return
	yield(owner,"ready")
	
	ship_components_hud.observe_ship(ship)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("A"):
		emit_signal("player_pressed_A")


func _on_saw_ship_area_triggered() -> void:
	Text.say_and_wait_for_input("Oh there's my ship!")


func _on_closer_look_triggered() -> void:
	Text.say_array([
		"Wait, it's only the hull!!",
		"At least tell me the healing system is still working"
	])
	yield(Text,"finished")
	Text.say("get inside the ship by pressing Z")


func _on_ship_pilot_entered(pilot) -> void:
	if entered_ship:
		return
	entered_ship = true
	yield(get_tree().create_timer(2.0, true),"timeout")
	
	Text.say_array([
		"Well it does! that's probably the only thing working right now.",
		"The teleport antenna isn't there, the gun is nowhere to be seen,",
		"and none of the jets are present. Also the dome is missing!",
		"If I wanna get home and also not be fired, I'm gonna have to find every component and get the hell out.",
		"But let's begin by repairing this mess (by pressing and holding X)"
	])
	
	yield(Text,"finished")
	
	set_health_to.trigger()
	
	Text.say("Enter and exit the ship with Z, repair by holding X (while outside the ship, and not being attacked)")
	
	player_controller.disabled = false
	
	
func pause():
	get_tree().paused = true


func unpause():
	for i in 2: #prevent jump after dialog end
		yield(get_tree(),"physics_frame")
	get_tree().paused = false


func _on_ship_health_full() -> void:
	if ship_health_full:
		return
	ship_health_full = true
	
	yield(get_tree().create_timer(0.5),"timeout")
	Text.say_array([
		"Now that's more like it, it's still a useless potato, but it's also healthy now!",
		"Let's see if we can find the rest of the ship components"
	])
	yield(Text,"finished")
	ship_components_hud.show()
	


func _on_saw_rear_jet_triggered() -> void:
	Text.say(
		"The REAR JET will allow the ship to move horizontally",7.5
	)

func _on_saw_up_jet_triggered() -> void:
	Text.say(
		"The UP JET will allow the ship to move UP (yes!)",7.5
	)

func _on_saw_down_jet_triggered() -> void:
	Text.say(
		"The DOWN JET will allow the ship to move DOWN",7.5
	)

func _on_saw_gun_triggered() -> void:
	Text.say(
		"The GUN will allow the ship to move GUN",7.5
	)


func _on_saw_dome_triggered() -> void:
	Text.say(
		"Finally, we don't have to worry about oxygen if the ship has this thing",7.5
	)

func _on_saw_teleporter_triggered() -> void:
	Text.say(
		"That's the teleporter antenna!!, if I put it on the ship I'll be able to teleport by pressing S",10.0
	)


func _on_teleporter_done() -> void:
	Text.say(
		"Great, now if I'm away from the ship, I can get back to it by pressing S"
	)
