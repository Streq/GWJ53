extends KinematicBody2D

export var spawn_pos = Vector2()

export var gravity := 5.0
export var damping := 0.0

export var in_water = false
export var water_gravity := -20
export var water_damping := 2.0

export var in_air := false
export var air_gravity := 100.0
export var air_damping := 1.0

export var floor_friction := 10.0

export var velocity := Vector2()

export var max_fall_speed := 100.0

var grabbed := false setget set_grabbed

export var COMPONENT : PackedScene

var ship_component = null

onready var sprite: Sprite = $Sprite
onready var panel: Sprite = $panel
onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
onready var pickedup_panel: Sprite = $pickedup_panel
onready var label: Label = $"%Label"

func _ready() -> void:
	spawn_pos = global_position

func _init() -> void:
	yield(self,"ready")
	ship_component = COMPONENT.instance()
	sprite.texture = ship_component.texture
	label.text = ship_component.label_name
func set_grabbed(val):
	grabbed = val
	panel.visible = !grabbed
	pickedup_panel.visible = grabbed
	set_physics_process(!grabbed)
	collision_shape_2d.disabled = grabbed

func _physics_process(delta: float) -> void:
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var _gravity = water_gravity if in_water else air_gravity if in_air else gravity 
	velocity.y += _gravity*delta
	var _damping =  water_damping if in_water else air_damping if in_air else damping
	velocity *= 1-delta*_damping
	
	velocity.y = min(velocity.y, max_fall_speed)
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0.0, delta*floor_friction)

func connect_to_ship(ship):
	for slot in ship.slots.get_children():
		if slot.type == ship_component.type:
			NodeUtils.reparent_or_add(ship_component, slot)
			ship_component.connect_to_slot(slot)
			queue_free()
func respawn():
	global_position = spawn_pos
	velocity = Vector2()
