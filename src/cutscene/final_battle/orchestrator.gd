extends Node

export var skip_intro:= false 
export var skip_fight:= false 
export var skip_talking:= false 

onready var ship: KinematicBody2D = $"%ship"
onready var dude: KinematicBody2D = $"%dude"

onready var invisible_wall: StaticBody2D = $"%invisible_wall"

onready var set_controller = $"%set_controller"
onready var player_controller: Node = $"%player_controller"
onready var black_background: Node2D = $"%black_background"
onready var perimeter: Node2D = $"%perimeter"
onready var pause_client: Node = $"%pause_client"
onready var came_in_beacon: Position2D = $"%came_in_beacon"
onready var boss_spawn_area: Area2D = $"%boss_spawn_area"
onready var meteor: KinematicBody2D = $"%meteor"
onready var boss_hud: CanvasLayer = $"%boss_hud"
onready var boss_health_bar: TextureProgress = $"%health_bar"
onready var map: Node2D = $"../map"
onready var shrink_sound: AudioStreamPlayer2D = $"%shrink_sound"
onready var detect_inside_lava_bubble: Node2D = $"%detect_inside_lava_bubble"
onready var dead_meteor_sprite: Node2D = $"%dead_meteor_sprite"

onready var meteor_radar: Node2D = $"%meteor_radar"

onready var meteor_appear: AnimationPlayer = $"%meteor_appear"

export var LAVA_RING : PackedScene
onready var meteor_pause_client: Node = $"%meteor_pause_client"
onready var meteor_shake = $"%meteor_shake"

onready var teleport_area: Polygon2D = $"%teleport_area"
onready var meteor_teleport : Node = meteor.get_node("%teleport")
var boss_triggered = false

signal player_can_leave()
signal player_left()
signal player_outside_bubble()


func _ready() -> void:
	if !skip_intro and !SessionState.skip_meteor_intro:
		Music.stop()
	yield(owner,"ready")
	
	if !skip_intro and !SessionState.skip_meteor_intro:
		yield(intro_sequence(),"completed")
	else:
		boss_quick_setup()
	
	SessionState.skip_meteor_intro = true
	yield(boss_fight(),"completed")

onready var player_position_on_quick_setup: Position2D = $"%player_position_on_quick_setup"
onready var boss_position_on_quick_setup: Position2D = $"%boss_position_on_quick_setup"
onready var player_HUD = dude.get_node("%HUD")
	

func boss_quick_setup():
	ship.global_position = player_position_on_quick_setup.global_position
	meteor.global_position = boss_position_on_quick_setup.global_position
	player_HUD.show()
	player_controller.disabled = false
	set_controller.disabled = true
	pause_client.paused_at_level = PauseState.Level.WORLD
	meteor.set_physics_process(true)
	meteor_pause_client.paused_at_level = PauseState.Level.WORLD
	invisible_wall.queue_free()
	black_background.queue_free()
	boss_triggered = true
	if !skip_fight and !SessionState.skip_meteor_fight:
		Music.call_deferred("play","meteor")
	
func intro_sequence():
	player_HUD.hide()
	meteor_radar.hide()
	ship.get_node("%gun_slot").rotation = Vector2.UP.angle()
	
	detect_inside_lava_bubble.set_physics_process(false)
	var meteor_controller = meteor.get_node("%controller")
	meteor.set_physics_process(false)
	meteor_controller.enabled = false
	for i in 5:
		yield(get_tree(),"idle_frame")
	
	Text.say_array([
		"And so he bounced, he bounced as hard as he could",
		"But he couldn't leave."],"narrator")
	
	yield(Text,"finished")
	yield(get_tree().create_timer(0.5),"timeout")
	invisible_wall.queue_free()
	yield(get_tree(),"idle_frame")
	ship.velocity = Vector2(0,-1000.0)
	yield(ship,"crash_collision")
	player_HUD.show()
	
	set_controller.dir = Vector2()
	yield(get_tree().create_timer(0.5),"timeout")
	
	black_background.queue_free()
	
	Text.say_array(["What the..?", "Did I just land on my head?", 
		"No, this is a ceiling.", 
		"Why is there a floating ceiling with water upside down here?"
	])
	Text.say_array(["Maybe I didn't notice it the first time, what with the crash and all that."])
	Text.say_array(["Anyway, let's look for a way around this thing so we can finally leave."])
	
	yield(Text,"finished")
	player_controller.disabled = false
	set_controller.disabled = true
	pause_client.paused_at_level = PauseState.Level.WORLD
	
	for i in 8:
		yield(perimeter,"seen_beacon")
	Text.say_array(["Wow, this place seems to be huge!"])
	
	yield(perimeter,"full_perimeter")
	
	boss_triggered = true
	Text.say_array(["I think"])
	Text.say_array(["I think we are trapped, which makes no sense."])
	Text.say_array(["Man, how the hell did I end up in this mess."])
	yield(Text,"finished")
	yield(get_tree().create_timer(2.0),"timeout")
	if boss_spawn_area.get_overlapping_bodies():
		yield(boss_spawn_area,"nothing_overlaps")
	
	Text.say_array(["You cannot leave this place"],"meteor")
	
	Text.say_array(["Who's there?"])
	yield(Text,"finished")
	
	Music.play("meteor")
	
	meteor_pause_client.paused_at_level = PauseState.Level.MENU
	Pause.pause(PauseState.Level.TEXT)
	meteor.set_physics_process(true)
	meteor.global_position = boss_spawn_area.global_position
	meteor_pause_client.paused_at_level = PauseState.Level.WORLD
	meteor_appear.play("play")
	var pupil = meteor.get_node("%pupil")
	pupil.look_at(dude.global_position)
	yield(meteor_appear,"animation_finished")
	
	Pause.unpause(PauseState.Level.TEXT)
	
	Text.say_array(["Hey! It's you! You are the giant rock that hit my ship!"])

	yield(new_reasoning(),"completed")
	

func new_reasoning():
	Text.say_array(["I apologize for the suffering and false hope I have caused you.",
	"I am the guardian of this world.",
	"You were never meant to survive our first encounter."],"meteor")
	
	yield(Text,"finished")
	
	Text.say_array(["What? why? What did I even do?"])

	Text.say_array(["Nothing yet","But I know your kind, I know what you are.",
	"You are a conqueror's scout.",
	"You intend to leave this place to inform other members of your lesser species on the benefits of its colonization."],"meteor")

	Text.say_array(["No man, I'm just here to pick up some flowers.",
	"You see. This is company policy, I work for an alien biology magazine, I collect samples that are used to make articles on how life is on other planets.",
	"But that's as far as we go, most of the time my samples get shelved.",
	"I collected samples from about 40 different planets.",
	"The craziest thing they ever did with them was feature them on Discovery Channel."])

	Text.say_array(["I did not understand anything you just said.",
	"But it does not matter.",
	"I have no reason to believe you, and lose nothing by being wrong.",
	"When it comes to the life under my protection, I shall take no chances."],"meteor")

	Text.say_array(["...So am I like, gonna die now?"])

	Text.say_array(["No, quite the contrary."],"meteor")

	Text.say_array(["Phew.",
	"Wait. What does that mean?"])

	Text.say_array(["You will feed and turn into the life of this world."],"meteor")
	
	Text.say_array(["That sounds really nasty."])
	Text.say_array(["What if I refuse? Can I refuse?"])
	Text.say_array(["I refuse."])
	
	Text.say_array(["It will make no difference."],"meteor")
	
	Text.say_array(["Yeah, well, I guess we'll see about that."])
	
	yield(Text,"finished")


func old_reasoning():
	Text.say_array(["I do not remember that."],"meteor")

	Text.say_array(["Well, it happened. Don't play silly with me."])

	Text.say_array([
		"If it did, I cannot possibly remember, as up until mere moments ago, I've been asleep for what I recon were eons, travelling the universe.",
		"My mind completely frozen in blissful rest.",
		"I must have landed in this planet not long ago, which is now a part of me as I am a part of it.",
		"And you awakened me."
	],"meteor")

	Text.say_array(["I did? What? When I picked up that jet thingy?"])

	Text.say_array(["Yes, yes.", "The jet thingy."],"meteor")

	Text.say_array(["Now how the hell did crashing into a ship and a planet short after not disturb you, but me picking up this jet did."])

	Text.say_array(["Causation does not depend on you understanding it."],"meteor")

	Text.say_array(["...Okay, well, suppose you are right, surely you will understand it was an accident and let me go, right?"])

	Text.say_array(["I will not do that."], "meteor")
	
	Text.say_array(["Goddamnit."])
	Text.say_array(["May I know why?"])

	Text.say_array([
		"Because once you leave this place, you will come back bringing other members of your lesser species with you.",
		"I know what you are.",
		"You are a conqueror's scout.",
		"You will lay waste to all life, in your quest to ravage and pillage, unhindered."
	],"meteor")
	
	Text.say_array(["No man, I just came here to pick up some flowers, I'm doing this because of company policy, no one ever does anything with these things anyway."])

	Text.say_array(["I've collected samples from about forty planets now, the craziest thing they ever did is feature them on Discovery Channel, and that happened like once."])

	Text.say_array(["I have no reason to believe you, and I face no consequence in being wrong."],"meteor")

	Text.say_array(["...So am I like, gonna die now?"])

	Text.say_array(["No, quite the contrary."],"meteor")

	Text.say_array(["Phew.",
	"Wait. What does that mean?"])

	Text.say_array(["You will turn into, and feed, the lifeforms of my new world."],"meteor")
	
	Text.say_array(["That sounds really nasty."])
	Text.say_array(["What if I resist?"])
	
	Text.say_array(["It will make no difference."],"meteor")
	Text.say_array(["Yeah, well, we'll see about that."])
	
	yield(Text,"finished")


var lava_ring

func boss_fight():
	meteor_teleport.set_custom_point_source(teleport_area)
	meteor_radar.show()
	boss_hud.show()
	meteor_teleport.teleport()
	
	var player_HUD = dude.get_node("%HUD")
	var bar = meteor.get_node("%health").bar
	bar.connect("value_changed",boss_health_bar,"set_values")
	bar.set_value(bar.value)
	var meteor_controller = meteor.get_node("%controller")
	meteor_controller.enabled = true
	
	
	if skip_fight or SessionState.skip_meteor_fight:
		meteor.queue_free()
	else:
		yield(meteor,"dying")
	SessionState.skip_meteor_fight = true
	Music.stop()
	get_tree().call_group("air","queue_free")
	get_tree().call_group("water","queue_free")
	dead_meteor_sprite.global_position = meteor.global_position
	yield(meteor,"tree_exiting")
	dead_meteor_sprite.show()
#	TODO
#	show_meteor_dead()
	
	boss_hud.queue_free()
	SessionState.has_beaten_meteor = true
	if !skip_talking:
		Text.say_array(["I am exhausted, I can fight no longer"],"meteor")
		Text.say_array(["Then maybe let me go and take a nap bozo"])
		Text.say_array(["No, you will not get your way, I will not let you destroy this place."],"meteor")
		yield(Text,"finished")
	
	meteor_shake.play("play")
	var lava_ring_cast_sound: AudioStreamPlayer2D = $"%lava_ring_cast_sound"
	lava_ring_cast_sound.play()
	
	yield(get_tree().create_timer(1.0),"timeout")
	
	meteor_shake.play("RESET")
	
	if !skip_talking:
		if SessionState.lava_ring_deaths == 0:
			Text.say_array(["What are you doing?"])
			yield(Text,"finished")
	set_controller.disabled = false
	set_controller.dir = Vector2()
	player_controller.disabled = true
	pause_client.set_paused_at_level(PauseState.Level.MENU)
	ship.velocity = Vector2()
	
	lava_ring = LAVA_RING.instance()
	owner.add_child(lava_ring)
	lava_ring.global_position = dude.global_position
	leave_world_area.global_position = dude.global_position
	shrink_sound.global_position = dude.global_position
	shrink_sound.play()
	lava_ring.trigger()
	
	yield(get_tree().create_timer(0.95),"timeout")
	
	detect_inside_lava_bubble.set_physics_process(true)
	pause_client.set_paused_at_level(PauseState.Level.WORLD)
	
	if !skip_talking:
		if SessionState.lava_ring_deaths < 3:
			Text.say_array(["This is an antinuclear matter bubble"],"meteor")
			Text.say_array(["It will instantly decompose every living thing it touches."],"meteor")
			
			yield(Text,"finished")
			yield(get_tree().create_timer(1.95),"timeout")
			
			
			Text.say_array(["UNORGANIC_MATERIALS"],"meteor")
			Text.say_array(["SHIP_CANT_PROTECT_YOU"],"meteor")
			
			yield(Text,"finished")
			yield(get_tree().create_timer(1.95),"timeout")
			
			Text.say_array(["I shall make it shrink slowly, so you have time to make peace with your demise."],"meteor")
			
			Text.say_array(["Cool."])
			
			yield(Text,"finished")
			yield(get_tree().create_timer(1.95),"timeout")
			
			Text.say_array(["As for me. I am done, along with this planet. We are both going to fade to nothing shortly."],"meteor")
			
			
			
			Text.say_array(["What? So that's it? We are both just gonna die and the planet will disappear?"])
			
			Text.say_array(["Yes"],"meteor")
			
			yield(Text,"finished")
			yield(get_tree().create_timer(1.95),"timeout")
			
			Text.say_array(["Then what the hell was the point of this?"])
			
			Text.say_array(["That you will not get to colonize the living beings of my planet, they will die free."],"meteor")
			Text.say_array(["Now I ask you, was it worth it?"],"meteor")
			
			Text.say_array(["Was what worth it? You are killing us both over nothing here."])
			
			Text.say_array(["I will take that as a negative. Farewell."],"meteor")
		else:
			Text.say_array(["That's an antinuclear matter bubble, I know, just go and let me die man"])
			Text.say_array(["Farewell."], "meteor")
		
		yield(Text,"finished")
	
	var tween = create_tween().set_loops(5)
	tween.tween_callback(dead_meteor_sprite,"set_visible",[true]).set_delay(0.1)
	tween.tween_callback(dead_meteor_sprite,"set_visible",[false]).set_delay(0.1)
	yield(tween,"finished")
	yield(get_tree().create_timer(0.1),"timeout")
	tween = create_tween().set_loops(5)
	tween.tween_callback(map,"set_visible",[true]).set_delay(0.1)
	tween.tween_callback(map,"set_visible",[false]).set_delay(0.1)
	yield(tween,"finished")
	dead_meteor_sprite.queue_free()
	map.queue_free()
	
	yield(get_tree().create_timer(1.0),"timeout")
	
	set_controller.disabled = true
	player_controller.disabled = false
	
	if !skip_talking:
		if SessionState.lava_ring_deaths < 2:
			Text.say_array(["Dumbass"])
			Text.say_array(["Okay, don't panic, there must be SOME way to get out of here"])
			Text.say_array(["The meteor said it decomposes \"living things\", maybe the ship itself is immune, but if *I* pass through it I'm done?"])
		
		elif SessionState.lava_ring_deaths < 4:
			Text.say_array(["Oh man I WISH I could just TELEPORT out of here."])
		
		elif SessionState.lava_ring_deaths >= 8:
			Text.say_array(["Okay this isn't going anywhere. Do you wanna know how to get out of here?"])
			Text.say_array(["If that's the case, check the latest message in the logs (by pressing Enter)"])
			yield(Text,"finished")
			Text.say("Just move toward the edge of the ring, press A, and then S right after, the ship will move through the ring unharmed (since it's not a living thing), and you will teleport outside the ring")
			Text.say("")

	
		yield(Text,"finished")
	
	count_death_as_lava()
	
	player_should_leave_bubble()
	yield(self,"player_outside_bubble")
	if dude.dead:
		return
	yield(get_tree().create_timer(0.5),"timeout")
	if dude.dead:
		return
	if SessionState.lava_ring_deaths == 0:
		Text.say_array(["DUDE.", "You are a GENIUS."])
	Text.say_array(["Ok let's get out of here."])
	yield(Text,"finished")
	
	player_can_leave()
	yield(self,"player_left")
	
	if is_instance_valid(lava_ring):
		lava_ring.queue_free()
		
	set_controller.disabled = false
	player_controller.disabled = true
	set_controller.dir = dude.input_state.dir
	if !set_controller.dir:
		set_controller.dir = Vector2(-1,-1)
	
	pause_client.set_paused_at_level(PauseState.Level.MENU)
	player_HUD.hide()
	
	var song = Music.play("end_song")
#	var song = Music.play("chill")
	yield(ending_second_version(),"completed")
	
	Text.say("THE END")
	yield(get_tree().create_timer(5.0),"timeout")
	song.continue_looping = false
	yield(song, "finished")
	
	ship.queue_free()
	Music.stop()
	Text.say("restarting.msg",3.0)
	yield(Text,"finished")
	
	SessionState.clear()
#	SessionState.can_skip_text = true
	
	get_tree().change_scene("res://src/cutscene/intro.tscn")
	
func ending_first_version():
	Text.say_array(["Ok, well, so the planet I collected these samples from just got completely disintegrated.",
	"That means this whole operation, along with everything we've been through, were pointless."])
	yield(Text,"finished")
	yield(get_tree().create_timer(2.0),"timeout")
	Text.say_array(["But my boss doesn't know that."])
	yield(Text,"finished")
	yield(get_tree().create_timer(1.0),"timeout")
	Text.say_array(["So we're just gonna play it cool with the flowers on monday, and see how it goes."])
	
	yield(Text,"finished")
	yield(get_tree().create_timer(2.0),"timeout")
	
	Text.say_array(["And that's how our hero escaped the evil meteor thing."],"narrator")
	Text.say_array(["Now he marches home, tired but relieved.",
	"He will not be there until 3 in the morning.",
	"He will have to shower and eat, but he will say \"I'm not dealing with that\" and just go right to sleep.",
	"On monday, he will present the samples, and his boss will congratulate him on the task, but ask where the ship's FTL Drive is.",
	"And our hero will say \"I don't know\""],"narrator")
	yield(Text,"finished")
	
func ending_second_version():
	
	Text.say_array(["And that's how our hero escaped the evil meteor thing."],"narrator")
	
	yield(Text,"finished")
	yield(get_tree().create_timer(1.0),"timeout")
	
	Text.say_array(["And since the planet he collected the bio samples from just got completely disintegrated",
	"This whole operation, along with everything he has been through, were pointless."],"narrator")
	yield(Text,"finished")
	yield(get_tree().create_timer(2.0),"timeout")
	Text.say_array(["But my boss doesn't know that."])
	yield(Text,"finished")
	yield(get_tree().create_timer(1.0),"timeout")
	Text.say_array(["But his boss doesn't know that."],"narrator")
	yield(Text,"finished")
	
	yield(get_tree().create_timer(1.0),"timeout")
	Text.say_array(["So he's just gonna play it cool with the flowers on monday, and see how it goes."],"narrator")
	
	yield(Text,"finished")
	yield(get_tree().create_timer(2.0),"timeout")
	
	Text.say_array(["Now he marches home, tired but relieved.",
	"He will not be there until 3 in the morning.",
	"He will have to shower and eat, but he will say \"I'm not dealing with that\" and just go right to sleep.",
	"On monday, he will present the samples, and his boss will congratulate him on the task, but ask where the ship's FTL Drive is.",
	"And our hero will say \"I don't know\""],"narrator")
	yield(Text,"finished")
	
	
	

func _on_came_in_beacon_seen() -> void:
	if boss_triggered:
		return
	yield(get_tree().create_timer(1.0),"timeout")
	Text.say_array(["Wait a second, this is the place I came from, there shouldn't be a wall here!!"])
	
func count_death_as_lava():
	dude.connect("dead", self, "on_lava_death")

var died_by_lava := false
func on_lava_death():
	if died_by_lava:
		return
	died_by_lava = true
	dude.disconnect("dead", self, "on_lava_death")

	SessionState.lava_ring_deaths += 1


onready var leave_world_area: Area2D = $"%leave_world_area"

func player_can_leave():
	emit_signal("player_can_leave")
	setup_win_by_player_left_entering_area()
	setup_win_by_player_left_exiting_area()
	setup_win_by_timeout()
	setup_win_by_lava_done()

func player_should_leave_bubble():
	setup_bubble_escape()
	setup_escape_by_lava_done()
	setup_escaped_by_player_left_entering_area()
	setup_escaped_by_player_left_exiting_area()


var lava_done = false
func setup_escaped_by_player_left_entering_area():
	yield(leave_world_area,"body_entered")
	print_debug("player escaped through enter")
	player_outside_bubble()
func setup_escaped_by_player_left_exiting_area():
	yield(leave_world_area,"body_exited")
	print_debug("player escaped through exit")
	player_outside_bubble()

func setup_bubble_escape():
	yield(detect_inside_lava_bubble,"outside")
	print_debug("player escaped bubble")
	player_outside_bubble()

func setup_escape_by_lava_done():
	yield(lava_ring,"done")
	lava_done = true
	player_outside_bubble()
	
func setup_win_by_player_left_entering_area():
	yield(leave_world_area,"body_entered")
	print_debug("won through entering area")
	emit_signal("player_left")
func setup_win_by_player_left_exiting_area():
	yield(leave_world_area,"body_exited")
	print_debug("won through exiting area")
	emit_signal("player_left")

func setup_win_by_timeout():
	yield(get_tree().create_timer(30.0),"timeout")
	print_debug("won through timeout")
	emit_signal("player_left")
	
func setup_win_by_lava_done():
	if !lava_done:
		yield(lava_ring,"done")
	yield(get_tree().create_timer(2.5),"timeout")
	emit_signal("player_left")

func player_outside_bubble():
	emit_signal("player_outside_bubble")
