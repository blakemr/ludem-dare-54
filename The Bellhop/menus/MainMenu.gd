extends Control

@export var tutorial_screen: Control
@export var start_level_path: String
var start_level: Node

func _ready() -> void:
	if start_level_path:
		var level_resource = load(start_level_path)
		start_level = level_resource.instantiate()

func start_game():
	if not start_level: 
		print("No start level!")
		return

	get_tree().root.add_child(start_level)
	queue_free()

func show_tutorial():
	tutorial_screen.show()

func hide_tutorial():
	tutorial_screen.hide()
