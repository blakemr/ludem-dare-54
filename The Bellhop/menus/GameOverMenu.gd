extends Control

@export var level_scene_path: String
var level_scene: Node
@export var main_menu_scene_path: String
var main_menu_scene: Node 

var score: int = 0:
	set(value):
		if score_label:
			score_label.text = str(value)

		score = value

@export var score_label: Label

func _ready() -> void:
	if level_scene_path:
		level_scene = load(level_scene_path).instantiate()

	if main_menu_scene_path:
		main_menu_scene = load(main_menu_scene_path).instantiate()

	if score_label:
		score_label.text = str(score)

func new_game() -> void:
	get_tree().root.add_child(level_scene)
	main_menu_scene.queue_free()
	queue_free()

func main_menu() -> void:
	get_tree().root.add_child(main_menu_scene)
	level_scene.queue_free()
	queue_free()
