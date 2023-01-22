extends Node

onready var center_of_scene: Control = $"../center_of_scene"
onready var appearing_label: Label = $"../appearing_label"
onready var dude_animation: AnimationPlayer = $"%dude_animation"
onready var dude: Control = $"%dude"
onready var spaceship_rocketing: ViewportContainer = $"%spaceship_rocketing"
onready var meteor_anim: AnimationPlayer = $"%meteor_anim"
onready var falling_particles: Node2D = $"%falling_particles"
onready var parachute: Sprite = $"%parachute"
onready var parachute_anim: AnimationPlayer = $"%parachute_anim"
onready var dude_sprite: Sprite = $"%dude_sprite"
onready var fallen_parachute: Sprite = $"%fallen_parachute"

var text_index = 0
	
func trigger() -> void:
	#step 0
	show_text("So there's this guy, right?")
	yield(appearing_label,"finished")

	yield(get_tree().create_timer(0.5),"timeout")
	dude_animation.play("idle")
	dude.show()
	yield(get_tree().create_timer(0.5),"timeout")

	owner.finish_step()
	yield(owner,"next_step")

	#step 1
	show_text("He's in the middle of nowhere in outer space.")
	yield(appearing_label,"finished")

	dude_animation.play("swim_idle")
	yield(get_tree().create_timer(0.5),"timeout")

	owner.finish_step()
	yield(owner,"next_step")

	#step 2
	show_text("In a spaceship about as big as a bathroom stall.")
	yield(appearing_label,"finished")
	dude.hide()
	spaceship_rocketing.show()
	owner.finish_step()
	yield(owner,"next_step")

	for text in [
		"He was supposed to bring back some bio samples from the closest earth like planet or something like that.",
#		"But he spent the whole time playing FTL on his phone.",
		"But he spent the whole time on his phone arguing online.",
		"So now it's late, the day is almost over, and he has to make it back quickly",
		"So he was pulling up to a planet that seemed to fit the criteria"
	]:
		show_text(text)
		yield(appearing_label,"finished")
		owner.finish_step()
		yield(owner,"next_step")

	#step 3
	show_text("But oh what the hell???")
	yield(appearing_label,"finished")
	spaceship_rocketing.show()
	dude.hide()
	meteor_anim.play("play")
	yield(meteor_anim,"animation_finished")

	falling_particles.show()
	owner.finish_step()
	yield(owner,"next_step")

	#step 4
	show_text("He got hit by some meteor like- I honestly wouldn't know I barely saw the thing.")
	yield(appearing_label,"finished")


	owner.finish_step()
	yield(owner,"next_step")

	#step 5
	appearing_label.text = ""
	yield(get_tree().create_timer(0.5),"timeout")

	dude.show()
	parachute_anim.play("play")
	yield(parachute_anim,"animation_finished")

	show_text("And the broken ship landed in this planet that's kinda like Earth but not quite.")
	yield(appearing_label,"finished")
	owner.finish_step()
	yield(owner,"next_step")


	spaceship_rocketing.hide()
	dude_sprite.position = Vector2()

	show_text("He survived, thankfully, but he doesn't have a clue where the dam ship landed")
	yield(appearing_label,"finished")

	owner.finish_step()
	yield(owner,"next_step")

	#step 6

	dude_animation.play("idle")
	fallen_parachute.show()
	parachute.hide()
	dude.show()
	
	
	for text in [
		"And yeah that guy is me!! I'm stranded on this planet, and it's friday.",
		"So you gonna help me or what?"
	]:
		show_text(text)
		yield(appearing_label,"finished")
		owner.finish_step()
		yield(owner,"next_step")
	
	owner.finish()
	
func _ready() -> void:
	owner.connect("trigger",self,"trigger")


func show_text(text):
	appearing_label.text = text
	appearing_label.trigger()
	text_index += 1
