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
	
	Text.say("Ok let's see where the ship is", 5.0)
	
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
	Text.say("Get inside the ship to heal by pressing Z")


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
		"But let's begin by repairing this mess first"
	])
	
	yield(Text,"finished")
	
	set_health_to.trigger()
	
	Text.say("Exit the ship with Z, once outside, repair by holding X (you can't repair if you've just been hurt)")
	
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
		"Now that's more like it!",
		"It's still a useless potato, but at least now it's not on the brink of falling apart!",
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
		"The GUN will allow the ship to GUN",7.5
	)


func _on_saw_dome_triggered() -> void:
	Text.say(
		"Finally, we don't have to worry about oxygen if the ship has this thing",7.5
	)

func _on_saw_teleporter_triggered() -> void:
	Text.say(
		"That's the teleporter antenna!!, if I put it on the ship I'll be able to teleport by pressing S",10.0
	)


onready var teleport_observer: Node = $"%teleport_observer"
func _on_teleporter_done() -> void:
	Text.say(
		"Great, now if I'm away from the ship, I can get back to it by pressing S"
	)
	yield(teleport_observer,"teleported")
	Text.say("Okay, this is epic", 4.0)


func _on_up_done() -> void:
	Text.say(
		"Hell yes!!, now we can actually FLY, I can't leave yet though, since there's no DOME to keep the air inside the ship",15.0
	)

onready var bio_sample_hud: Label = $"%bio_sample_HUD"

onready var bio_sample_radar: Node2D = $"%bio_sample_radar"

func _on_ship_components_HUD_ship_complete() -> void:
	Text.say_array([
		"Well that's it! I'm done here",
		"Let's power the ship and get out",
		"...",
		"...",
		"Oh right, the bio samples.",
		"Ok, let's just uhhhh", 
		"let's collect 10 flowers and call it a day", 
		"I conveniently got a flower radar in this thing so let's just get it over with",
		])
	yield(Text,"finished")
	bio_sample_hud.show()
	bio_sample_radar.show()
	
	get_tree().call_group("bio_sample","make_important")
	
	yield(bio_sample_hud,"done")
	
	Text.say_array([
		"Well that's it! I'm done here",
		"Let's power the ship and get out",
		"...",
		"...",
		"Oh right, the FTL Drive.",
		"No I'm just kidding I got no idea what that is", 
		"Ok let's bounce"
		])

onready var eye_spawner: Node2D = $"%eye_spawner"

func _on_down_jet_pickup_picked_up() -> void:
	Shake.shake(Vector2.RIGHT)
	yield(get_tree().create_timer(1.0),"timeout")
	Text.say_array(["Something's wrong", "I feel like I've awakened something"])
	eye_spawner.spawn()




func _on_rear_done() -> void:
	Text.say(
		"Ok, let's see if we can get the ship to move",7.5
	)


func _on_down_done() -> void:
	
	Text.say(
		"Great, this jet will allow us to dive into deep waters, now for the Dome and we're good to go!",7.5
	)
