extends Node

export var skip_intro := false setget set_skip_intro
export var skip_meteor_intro := false setget set_skip_meteor_intro
export var skip_meteor_fight := false setget set_skip_meteor_fight
export var has_repaired_ship := false setget set_has_repaired_ship
export var has_beaten_meteor := false setget set_has_beaten_meteor
export var lava_ring_deaths := 0 setget set_lava_ring_deaths
export var locale = "en" setget set_locale


func set_locale(val):
	locale = val
	_save()

func set_skip_intro(val):
	skip_intro = val
	_save()

func set_skip_meteor_fight(val):
	skip_meteor_fight = val
	_save()

func set_skip_meteor_intro(val):
	skip_meteor_intro = val
	_save()

func set_has_repaired_ship(val):
	has_repaired_ship = val
	_save()

#func set_can_skip_text(val):
#	can_skip_text = val
#	_save()

func set_has_beaten_meteor(val):
	has_beaten_meteor = val
	_save()

func set_lava_ring_deaths(val):
	lava_ring_deaths = val
	_save()

var SAVE_PATH := "user://stranded.save"

var loading = false
func _save():
	if loading:
		return
	var save_game = File.new()
	save_game.open(SAVE_PATH, File.WRITE)
	
	var save = {}
	
	for prop in get_script().get_script_property_list():
		var val = get(prop.name)
		save[prop.name] = val
	
	save_game.store_var(save)

func _load():
	loading = true
	clear()
	var save_game : File = File.new()
	
	if save_game.open(SAVE_PATH, File.READ) == 0:
			
		var save = save_game.get_var()
		if !save:
			loading = false
			return
		for prop in get_script().get_script_property_list():
			if save.has(prop.name):
				var val = save[prop.name]
				set(prop.name, val)
	loading = false

enum Components{
	REAR,
	TELEPORT,
	UP,
	GUN,
	DOWN,
	DOME
}

export (Components, FLAGS) var components

export (Array, bool) var flowers = [false,false,false,false,false,false,false,false,false,false]

export var current_checkpoint := -1

	
func clear():
	skip_intro = false
	skip_meteor_intro = false
	skip_meteor_fight = false
	has_repaired_ship = false
	has_beaten_meteor = false
	components = 0
	flowers = []
	for i in 10:
		flowers.append(false)
	current_checkpoint = -1
	
	
func should_ask_if_continue():
	return skip_intro

func set_component(component):
	components |= 1<<component
	_save()

func get_component(component):
	return ((components>>component)&1) == 1

func set_flower(index):
	flowers[index] = true
	_save()

func set_checkpoint(index):
	current_checkpoint = index
	_save()

func has_all_flowers():
	var count = 0
	for flower in flowers:
		if flower:
			count += 1
	return count == 10

func has_save():
	return File.new().open(SAVE_PATH, File.READ) == 0

func _ready() -> void:
	_load()
