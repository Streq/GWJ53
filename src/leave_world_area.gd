extends Area2D

onready var canvas_layer: CanvasLayer = $CanvasLayer

export var can_leave := false
export var got_components := false

var ended := false

export (String, FILE, "*.tscn") var RESTART_SCENE := "res://src/cutscene/intro.tscn"

func done():
	can_leave = true

func done_components():
	got_components = true

func _ready():
	canvas_layer.hide()
	
func _on_leave_world_area_body_entered(body: Node) -> void:
	if can_leave:
		end()
	else:
		go_back()
func end():
	if ended:
		return
	ended = true
	
	get_tree().change_scene("res://src/final_battle_intro.tscn")
	return
	
	canvas_layer.show()
	Text.say_array([
		"And so he bounced, he bounced as hard as he could",
		"But even though he bounced so hard, he wasn't home until 3 in the morning.",
		"He had to shower and eat, but he said \"I'm not dealing with that\" and just went right to sleep.",
		"On monday, he presented the bio samples, and his boss congratulated him on the task, but asked where the ship's FTL Drive was.",
		"He said \"I don't know\"",
	])
	get_tree().paused = true
	yield(Text,"finished")
	Text.say("THE END",5.0)
	yield(get_tree().create_timer(5.0),"timeout")
	get_tree().change_scene(RESTART_SCENE)
	


func dude():
	["And so he bounced, he bounced as hard as he could",
	"But something kept him"]

	["What the..? Why is there a ceiling now, and why is there water?"]

	["You cannot leave this place"]

	["Who's in there?"]

	["It matters not, for your curiosity will soon cease to perturb you"]

	["Wait a second. You are the giant rock that hit my ship in the first place!"]

	["I do not remember that."]

	["Well it happened. Don't play silly with me."]

	[
		"I cannot possibly remember, as I've been asleep for eons, travelling the universe.",
		"My mind completely frozen in blissful rest.",
		"Not long ago I must have landed in this planet, which is now a part of me as I am a part of it.",
		"And you awakened me."
	]

	["I did? YOU crashed into me!"]

	["No, our collision did not perturb me, you awakened me when you picked that... jet thingy, up."]

	["Now how the hell did crashing into a ship and a planet short after not disturb you, but me picking this jet up did."]

	["Your understanding of causation is of no relevance to it."]

	["...Ok, well, suppose you are right, why am I not allowed to leave?"]

	["Because you intend to leave this place to inform your lesser lifeform race that it can be conquered."]

	["No man, I just came here to pick up some flowers, I'm doing this because of company policy, no one ever does anything with these things."]

	["I've collected samples from about 40 planets now, the craziest thing they ever did is feature them on Discovery Channel once."]

	["I have no reason to believe you, and face no loss in being wrong."]

	["...So am I like, gonna die now?"]

	["No, quite the contrary."]

	["Phew. ",
	"Wait. What does that mean?"]

	["You will turn into, and feed, the lifeforms of my new world."]

	["Man fuck you."]



func go_back():
	if got_components:
		Text.say("I can't leave the planet yet, I gotta get the flowers!!!!", 10.0)
	else:
		Text.say("Leaving the atmosphere without the full ship was a bad idea", 10.0)
	
	get_tree().call_group("checkpoint_radar","show")

func _on_leave_world_area_body_exited(body: Node) -> void:
	get_tree().call_group("checkpoint_radar","hide")
