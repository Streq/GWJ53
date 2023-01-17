extends KinematicBody2D

export var gravity := 100.0
export var water_gravity := -20

export var damping := 1.0
export var water_damping := 2.0

export var floor_friction := 10.0

export var velocity := Vector2()

export var max_fall_speed := 100.0

var grabbed := false setget set_grabbed

export var COMPONENT : PackedScene

onready var panel: Sprite = $panel
onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
onready var pickedup_panel: Sprite = $pickedup_panel

var in_water = false

func set_grabbed(val):
	grabbed = val
	panel.visible = !grabbed
	pickedup_panel.visible = grabbed
	set_physics_process(!grabbed)
	collision_shape_2d.disabled = grabbed

func _physics_process(delta: float) -> void:
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var _gravity = gravity if !in_water else water_gravity
	velocity.y += _gravity*delta
	var _damping = damping if !in_water else water_damping
	velocity *= 1-delta*_damping
	
	velocity.y = min(velocity.y, max_fall_speed)
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0.0, delta*floor_friction)

func connect_to_ship(ship):
	pass
