extends Node

onready var hurt_palette: Node = $hurt_palette
onready var default_palette: Node = $default_palette
onready var hurtbox: Node = $"%hurtbox"
onready var lifetime: Timer = $lifetime

var material : Material = null


func _ready() -> void:
	hurtbox.connect("hurt",self,"trigger")
func trigger():
	SFX.play("enemy_hurt", get_parent().global_position)
	
	hurt_palette.update_parent_material()
	get_parent().material = material
	
	lifetime.start()
	yield(lifetime,"timeout")
	
	default_palette.update_parent_material()
	get_parent().material = material
	
	
