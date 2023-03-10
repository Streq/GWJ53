extends Area2D

signal active()
signal restart()

const ACTIVE_CHECKPOINT = "active_checkpoint"
onready var player_spawn: Position2D = $player_spawn
onready var ship_spawn: Position2D = $ship_spawn
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var label: Label = $Label

var player = null
var ship = null

func _ready() -> void:
	player = Group.get_one("player")
	ship = Group.get_one("ship")


func on():
	get_tree().call_group(ACTIVE_CHECKPOINT,"off")
	add_to_group(ACTIVE_CHECKPOINT)
	player.connect("dead",self,"revive")
	ship.connect("dead",self,"revive")
	self.connect("restart",owner,"restart")
	animation_player.play("on")
	set_deferred("monitoring",false)
	emit_signal("active")
	
	label.show()
	yield(get_tree().create_timer(2.0),"timeout")
	label.hide()
	
func off():
	remove_from_group(ACTIVE_CHECKPOINT)
	player.disconnect("dead",self,"revive")
	ship.disconnect("dead",self,"revive")
	self.disconnect("restart",owner,"restart")
	animation_player.play("off")
	set_deferred("monitoring",true)
	label.hide()
	
func revive():
	yield(get_tree().create_timer(1.0),"timeout")
	Text.say("Oh it was just some vivid thought, thank goodness!", 5.0)
	revive_quick()

func revive_quick():
	player.global_position = player_spawn.global_position
	player.revive()
	ship.global_position = ship_spawn.global_position
	ship.revive()
	player.velocity = Vector2()
	ship.velocity = Vector2()
	
	emit_signal("restart")

	
func _on_checkpoint_body_entered(body: Node) -> void:
	on()
	
