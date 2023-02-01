extends Node

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
onready var player_exited_area: Area2D = $"%player exited_area"
onready var dead_meteor_sprite: Sprite = $"%dead_meteor_sprite"



export var LAVA_RING : PackedScene

var boss_triggered = false

func _ready() -> void:
	yield(owner,"ready")
	var player_HUD = dude.get_node("%HUD")
	player_HUD.hide()
	
	ship.get_node("%gun_slot").rotation = Vector2.UP.angle()
	
	detect_inside_lava_bubble.set_physics_process(false)
	var meteor_controller = meteor.get_node("%controller")
	meteor.set_physics_process(false)
	meteor_controller.enabled = false
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
	
	if false:
	
	
	
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
	meteor.set_physics_process(true)
	meteor.global_position = boss_spawn_area.global_position
	
	Text.say_array(["It matters not.", "For your curiosity will soon cease to perturb you"],"meteor")

	Text.say_array(["Wait a second. You are the giant rock that hit my ship in the first place, aren't you!"])

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
		"Because I know what you are.",
		"You are a conqueror's scout.",
		"Once you leave this place, you will come back bringing other members of your lesser species with you.",
		"I know your kind.",
		"You will lay waste to all life, in your quest to ravage and pillage, unhindered."
	],"meteor")
	
#	Text.say_array(["Because you intend to leave this place to inform your lesser lifeform race that it's a planet that can be conquered."])

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
	boss_hud.show()
	var bar = meteor.get_node("%health").bar
	bar.connect("value_changed",boss_health_bar,"set_values")
	bar.set_value(bar.value)
	meteor_controller.enabled = true

	yield(meteor,"dying")
	dead_meteor_sprite.global_position = meteor.global_position
	yield(meteor,"tree_exiting")
	dead_meteor_sprite.show()
#	TODO
#	show_meteor_dead()
	
	boss_hud.queue_free()
	
	Text.say_array(["I am exhausted, I can fight no longer"],"meteor")
	Text.say_array(["Then maybe take another nap bozo"])
	Text.say_array(["No, you will not get your way, I will not let you destroy this place."],"meteor")
	Text.say_array(["What are you doing?"])
	
	yield(Text,"finished")
	set_controller.disabled = false
	set_controller.dir = Vector2()
	player_controller.disabled = true
	pause_client.set_paused_at_level(PauseState.Level.MENU)
	ship.velocity = Vector2()
	
	var lava_ring = LAVA_RING.instance()
	owner.add_child(lava_ring)
	lava_ring.global_position = dude.global_position
	
	shrink_sound.global_position = dude.global_position
	shrink_sound.play()
	
	yield(get_tree().create_timer(1.5),"timeout")
	set_controller.disabled = true
	player_controller.disabled = false
	pause_client.set_paused_at_level(PauseState.Level.WORLD)
	
	
	detect_inside_lava_bubble.set_physics_process(true)
	
	Text.say_array(["This is an anticellular matter bubble"],"meteor")
	Text.say_array(["It will instantly decompose every living thing it touches."],"meteor")
	Text.say_array(["I shall make it shrink slowly, so you have enough time to make peace with your demise."],"meteor")
	
	Text.say_array(["Cool."])
	
	Text.say_array(["As for me. I'm done, along with this planet. We are both going to fade to nothing shortly."],"meteor")
	
	Text.say_array(["Now I ask you, was it worth it?"],"meteor")
	
	Text.say_array(["Not really, no."])
	
	Text.say_array(["I imagined so. Farewell."],"meteor")
	yield(Text,"finished")
	
	var tween = create_tween().set_loops(5)
	tween.tween_callback(dead_meteor_sprite,"set_visible",[false]).set_delay(0.1)
	tween.tween_callback(map,"set_visible",[false])
	tween.tween_callback(dead_meteor_sprite,"set_visible",[true]).set_delay(0.1)
	tween.tween_callback(map,"set_visible",[true])
	yield(tween,"finished")
	dead_meteor_sprite.queue_free()
	map.queue_free()
	lava_ring.trigger()
	player_exited_area.global_position = lava_ring.global_position
	
	
	yield(detect_inside_lava_bubble,"outside")
	if dude.dead:
		return
	yield(get_tree().create_timer(2.0),"timeout")
	Text.say_array(["Ok let's get out of here."])
	yield(Text,"finished")
	
	if player_exited_area.overlaps_body(dude):
		yield(player_exited_area,"body_exited")
	else:
		yield(get_tree().create_timer(2.0),"timeout")
	
	if is_instance_valid(lava_ring):
		lava_ring.queue_free()
		
	set_controller.disabled = false
	player_controller.disabled = true
	set_controller.dir = dude.input_state.dir
	if !set_controller.dir:
		set_controller.dir = Vector2(-1,-1)
	
	pause_client.set_paused_at_level(PauseState.Level.MENU)
	player_HUD.hide()
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
	"On monday, he will present the bio samples, and his boss will congratulate him on the task, but ask where the ship's FTL Drive is.",
	"And our hero will say \"I don't know\""],"narrator")
	yield(Text,"finished")
#	yield(get_tree().create_timer(2.0),"timeout")
	

	
	Text.say("THE END",5.0)
	yield(Text,"finished")
	
	get_tree().change_scene("res://src/cutscene/intro.tscn")
	return
	
	
	
	

func _on_came_in_beacon_seen() -> void:
	if boss_triggered:
		return
	yield(get_tree().create_timer(1.0),"timeout")
	Text.say_array(["Wait a second, this is the place I came from, there shouldn't be a wall here!!"])
	
