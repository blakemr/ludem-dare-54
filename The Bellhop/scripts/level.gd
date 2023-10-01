extends Node2D

@export var pause_screen: Control
@export var game_over_scene_path: String
var game_over_scene: Node
var max_passenger_label: Node
var passenger_label: Node
var score: int = 0:
	set(value):
		if score_label:
			score_label.text = str(value)

		score = value

@export var passenger_generator: PassengerGenerator
@export var initial_spawn_speed: float = 2.0

@export var score_label: Label

@export var demo: bool = false

# Test script
func _ready() -> void:
	if demo: return

	randomize()
	if has_node("PassengerGenerator"):
		$PassengerGenerator.new_passenger.connect(place_passenger)
		$PassengerGenerator.start()

	if pause_screen: pause_screen.hide()

	if game_over_scene_path:
		game_over_scene = load(game_over_scene_path).instantiate()

	max_passenger_label = %MaxPassengerCountLabel
	passenger_label = %PassengerCountLabel

	set_max_passengers($Elevator.max_capacity)

	passenger_generator.wait_time = initial_spawn_speed

	score = 0

func place_passenger(pas: Passenger) -> void:

	var floors = $Floors.get_children()
	var current_floor = floors[pas.start_floor]
	var size = current_floor.size
	#var floor_size = floors[pas.start_floor].size
	#var floor_position = floors[pas.start_floor].global_position

	current_floor.add_child(pas)
	pas.position = size/2 + Vector2(randf_range(-size.x/2, size.x/2), randf_range(-size.y/2, size.y/2)) 

	#pas.global_position = floor_position + floor_size/2 + Vector2(randf_range(-floor_size.x/2, floor_size.x/2), randf_range(-floor_size.y/2, floor_size.y/2))

func add_score(value: int) -> void:
	score += value

	# formula tuned via testing
	# a score of 1 = 2s spawn
	# a score of 7 ~= 1s spawn
	# a score of 79 = 0.5s spawn
	passenger_generator.wait_time = initial_spawn_speed*log(3)/log(score + 2)

func set_max_passengers(value: int) -> void:
	if not max_passenger_label: return
	max_passenger_label.text = str(value)

func set_current_passengers(value: int) -> void:
	if not passenger_label: return
	passenger_label.text = str(value)

func show_pause_screen() -> void:
	if pause_screen: pause_screen.show()

func game_over() -> void:
	get_tree().root.add_child(game_over_scene)
	if game_over_scene.get("score") != null:
		game_over_scene.score = str(score)

	queue_free()
