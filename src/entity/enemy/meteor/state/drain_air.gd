extends CharacterState
signal done()

onready var duration: Timer = $duration
onready var post_duration: Timer = $post_duration
onready var pull_player: Node2D = $"%pull_player"

var done = false
var drain = false
func _ready() -> void:
	duration.connect("timeout",self,"drain")
	post_duration.connect("timeout",self,"finish")
	
func _enter(params):
	Text.say("Air. Water. Gravity.\nLet's see how well a lesser lifeform fares without.", 7.5, "meteor")
	root.velocity = Vector2()
	duration.start()
	done = false
	drain = false
	
func _physics_update(delta:float) -> void:
	if drain:
		emit_signal("drain")
		get_tree().call_group("air","queue_free")
		get_tree().call_group("water","queue_free")
		pull_player.enabled = true
		post_duration.start()
		drain = false
	if done:
		emit_signal("done")
		goto(on_finish_goto_state)
		return
	
func _exit() -> void:
	duration.stop()
	pull_player.enabled = false
	


func finish():
	done = true
	
func drain():
	drain = true
