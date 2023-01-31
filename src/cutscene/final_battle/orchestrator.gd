extends Node

onready var ship: KinematicBody2D = $"%ship"

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

func _ready() -> void:
	
	yield(owner,"ready")
	var meteor_controller = meteor.get_node("%controller")
	meteor.set_physics_process(false)
	meteor_controller.enabled = false
	Text.say_array([
		"And so he bounced, he bounced as hard as he could",
		"But he couldn't leave."])
	yield(Text,"finished")
	yield(get_tree().create_timer(0.5),"timeout")
	invisible_wall.queue_free()
	yield(get_tree(),"idle_frame")
	ship.velocity = Vector2(0,-1000.0)
	yield(ship,"crash_collision")
	set_controller.dir = Vector2()
	yield(get_tree().create_timer(0.5),"timeout")
	
	black_background.queue_free()
	
	Text.say_array(["What the..?","Huh. that's strange.", "I don't recall seeing a floating ceiling with water upside down on my way here."])
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
	
	Text.say_array(["I think"])
	Text.say_array(["I think we are trapped, which makes no sense."])
	Text.say_array(["Man, how the hell did I end up in this mess."])
	
	
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
	
	Text.say_array(["Gosh dang it to heck."])
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

	Text.say_array(["I have no reason to believe you, and face no consequence in being wrong."],"meteor")

	Text.say_array(["...So am I like, gonna die now?"])

	Text.say_array(["No, quite the contrary."],"meteor")

	Text.say_array(["Phew.",
	"Wait. What does that mean?"])

	Text.say_array(["You will turn into, and feed, the lifeforms of my new world."],"meteor")

	Text.say_array(["Man screw that, I'm shooting your ass."])
	yield(Text,"finished")
	boss_hud.show()
	var bar = meteor.get_node("%health").bar
	bar.connect("value_changed",boss_health_bar,"set_values")
	bar.set_value(bar.value)
	meteor_controller.enabled = true

	yield(meteor,"dying")
	Text.say_array(["I am exhausted, I can fight no longer"],"meteor")
	Text.say_array(["Then maybe take another nap bozo"])
	Text.say_array(["No, you will not get your way, I will not let you destroy this place."],"meteor")
	Text.say_array(["What are you doing?"])
	Text.say_array(["I'm turning into a star, I will perish, along with you and this place, but I'd rather die and turn this world into star fuel than let you colonize it"],"meteor")
	Text.say_array(["You should seriously consider that nap"])
	Text.say_array(["You know what? fine, whatever, it's whatever"],"meteor")
	Text.say_array(["Wait, seriously?"])
	Text.say_array(["Yes, I'm tired, and I realized nothing is keeping me from going back to sleep. This just isn't worth it.",
	"I bid you farewell."],"meteor")

	Text.say_array(["I guess so?"])

	Text.say_array(["Well that was weird but whatever, let's go home."])


func _on_came_in_beacon_seen() -> void:
	yield(get_tree().create_timer(1.0),"timeout")
	Text.say_array(["Wait a second, this is the place I came from, there shouldn't be a wall here!!"])
	
