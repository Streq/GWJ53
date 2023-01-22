extends Area2D

const ACTIVE_CHECKPOINT = "active_checkpoint"
onready var player_spawn: Position2D = $player_spawn
onready var ship_spawn: Position2D = $ship_spawn
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var label: Label = $Label

var player = null
var ship = null

func on():
	get_tree().call_group(ACTIVE_CHECKPOINT,"off")
	add_to_group(ACTIVE_CHECKPOINT)
	player.connect("dead",self,"revive")
	ship.connect("dead",self,"revive")
	animation_player.play("on")
	set_deferred("monitoring",false)
	label.show()
	yield(get_tree().create_timer(2.0),"timeout")
	label.hide()
	
func off():
	remove_from_group(ACTIVE_CHECKPOINT)
	player.disconnect("dead",self,"revive")
	ship.disconnect("dead",self,"revive")
	animation_player.play("off")
	set_deferred("monitoring",true)
	label.hide()
	
func revive():
	yield(get_tree().create_timer(1.0),"timeout")
	player.global_position = player_spawn.global_position
	player.revive()
	ship.global_position = ship_spawn.global_position
	ship.revive()
	get_tree().call_group("pickup","respawn")

func _on_checkpoint_body_entered(body: Node) -> void:
	player = body
	ship = Group.get_one("ship")
	
	on()
	
