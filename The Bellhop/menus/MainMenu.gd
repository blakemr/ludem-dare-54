extends Control

@export var tutorial_screen: Control
@export var start_level: PackedScene

func start_game():
	if not start_level: 
		print("No start level!")
		return

	var level = start_level.instantiate()
	get_tree().root.add_child(level)
	hide()

func show_tutorial():
	tutorial_screen.show()

func hide_tutorial():
	tutorial_screen.hide()
