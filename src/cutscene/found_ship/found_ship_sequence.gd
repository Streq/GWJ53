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
	Text.say_array(["Oh there's my ship!"])


func _on_closer_look_triggered() -> void:
	Text.say_array([
		"Wait, it's only the hull!!",
		"At least tell me the healing system is still working"
	])
	yield(Text,"finished")
	Text.say("Get inside the ship to heal by pressing A")


func _on_ship_pilot_entered(pilot) -> void:
	if entered_ship:
		return
	entered_ship = true
	var player_was_hurt_before_healing = !pilot.get_node("%health").is_full()
	
	yield(get_tree().create_timer(2.5, true),"timeout")
	
	if player_was_hurt_before_healing:
		Text.say_array([
			"It works!"
		])
	else:
		Text.say_array([
			"It works!",
			"I mean I wouldn't know, since I wasn't hurt, but it seems to be intact!"
		])
	
	
	Text.say_array([
		"That's probably the only thing working right now.",
		"The teleport antenna isn't there, the gun is nowhere to be seen,",
		"and none of the jets are present. Also the dome is missing!",
		"If I wanna get home and also not be fired, I'm gonna have to find every component and get the hell out.",
		"But let's begin by repairing this mess first"
	])
	
	
	yield(Text,"finished")
	
	set_health_to.trigger()
	
	Text.say("Exit the ship with A, once outside, repair by holding X (you can't repair if you've just been hurt)")
	
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
		"Let's see if we can find the rest of the ship components",
		"Also I've no idea how to say this without sounding weird but you can pause by pressing ENTER"
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
	var stamp = Text.latest_stamp
	yield(teleport_observer,"teleported")
	if Text.latest_stamp == stamp:
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
	
	Text.say("Some dots have appeared on the border of the screen, just follow them to find the flowers!",7.5)
	
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
onready var rumble: AudioStreamPlayer2D = $"%rumble"

var down_jet_picked_up := false


func _on_down_jet_pickup_respawn() -> void:
	reset_rumble()

onready var protected_zone_detect: Area2D = $"%protected_zone_detect"

func reset_rumble():
	down_jet_picked_up = false
	eye_spawner.stop()
	protected_zone_detect.set_deferred("monitoring", false)
	protected_zone_detect.enabled = false
	
func _on_down_jet_pickup_picked_up() -> void:
	if down_jet_picked_up:
		return
	
	down_jet_picked_up = true
	Shake.shake(Vector2.RIGHT)
	rumble.play()
	yield(get_tree().create_timer(1.0),"timeout")
	Text.say_array(["Something's wrong", "I feel like I've awakened something"])
	eye_spawner.spawn()
	protected_zone_detect.set_deferred("monitoring", true)
	protected_zone_detect.enabled = true



func _on_rear_done() -> void:
	Text.say(
		"Ok, let's see if we can get the ship to move",7.5
	)


func _on_down_done() -> void:
	
	Text.say(
		"Great, this jet will allow us to dive into deep waters, now for the Dome and we're good to go!",10.0
	)


func _on_gun_done() -> void:
	Text.say(
		"Now we can fend for ourselves, shoot by holding X, tap to shoot faster, if you hold Z you can brake the jets, allowing you to aim without moving",20.0
	)




var saw_locals = false
func _on_saw_local_triggered() -> void:
	if saw_locals:
		return
	saw_locals = true
	Text.say(
		"Oh look! some locals! Maybe we can talk to them by pressing X!", 5.0
	)

var talked_to_locals = false
var too_far_from_local = true
func _on_talked_to_locals_triggered() -> void:
	if talked_to_locals:
		return
	talked_to_locals = true
	
	
	var stamp = 0
	
	
	for entry in [
		["Hey! I'm an alien, but I come in peace!", 4.0],
		["I'm here by accident in fact,", 4.0],
		["and am kind of stranded right now.", 4.0],
		["Could you help me find my ship?", 4.0],
		["", 2.0],
		["Wow, won't even stop and look at me.", 3.0],
		["", 1.0],
		["Whatever.", 3.0],
		["", 1.0],
		["Rude ass.", 3.0],
		["Maybe I don't come in peace.", 3.0],
		["", 1.0],
		["Nothing. It's like I'm talking to a wall here.", 3.0],
		["", 1.0],
		["Maybe they can't hear me?", 3.0],
		["Yeah it's probably that", 3.0],
		["I'm sorry for calling you rude if that's the case", 3.0],
		["", 1.0],
		["Ok, uhhhh", 3.0], 
		["I'm gonna go find my ship now.", 3.0],
		["Good luck with the walking.", 3.0]
	]:
		Text.say(entry[0],entry[1])
		stamp = Text.latest_stamp
		yield(Text,"done_with_current_text")
		if stamp != Text.latest_stamp or too_far_from_local:
			return
		

var touched_by_locals = false
func _on_touched_by_local_triggered() -> void:
	if touched_by_locals:
		return
	touched_by_locals = true
	Text.say(
		""
	)
	
	yield(get_tree().create_timer(1.0, true),"timeout")
	Text.say(
		"Ok no talking", 5.0
	)
	


var saw_spike = false
func _on_saw_spike_body_entered(body: Node) -> void:
	if saw_spike:
		return
	saw_spike = true
	Text.say(
		"I better avoid these", 5.0
	)


func _on_locals_close_body_entered(body: Node) -> void:
	too_far_from_local = false


func _on_locals_close_body_exited(body: Node) -> void:
	too_far_from_local = true


func _on_local_hitbox_hit() -> void:
	_on_touched_by_local_triggered()
