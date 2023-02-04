extends Node


var menu_stack = []

func push(menu):
	if menu_stack:
		menu_stack.back().exit()
	menu_stack.append(menu)
	menu.enter()

func push_array(arr):
	if menu_stack:
		menu_stack.back().exit()
	menu_stack.append_array(arr)
	menu_stack.back().enter()

func pop():
	if !menu_stack:
		return
	menu_stack.back().exit()
	menu_stack.pop_back()
	if !menu_stack:
		return
	menu_stack.back().enter()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("START"):
		if !menu_stack:
			get_tree().set_input_as_handled()
			push(PauseMenu)
			
