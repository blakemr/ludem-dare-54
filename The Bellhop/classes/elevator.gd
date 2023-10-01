class_name Elevator
extends Node2D

signal over_capacity
signal over_weight

signal floor_arrived

@export var max_capacity: int = 10
@export var max_weight_limit: int = 100
@export var animation_speed = 1.0
var current_floor: int = 0

@onready var sprite := $ElevatorSprite

func _ready() -> void:
	z_index = 5

var capacity: int = 0:
	set(value):
		if value > max_capacity:
			over_capacity.emit()

		capacity = value

var weight: int = 0:
	set(value):
		if value > max_weight_limit:
			over_weight.emit()

		weight = value

var moving: bool = false

func call_recieved(pos: Vector2, floor_node: Floor) -> void:
	if moving: return

	current_floor = floor_node.floor_number

	# Loading block
	moving = true
	
	await move(pos).finished
	unload_passengers()
	load_passengers(floor_node)

	# Wait for loading/unloading
	sprite.frame = 1
	await get_tree().create_timer(animation_speed).timeout
	sprite.frame = 0

	moving = false

func move(pos: Vector2) -> Tween:
	var tween = create_tween()
	tween.tween_property(self, "global_position", pos, animation_speed).set_trans(Tween.TRANS_BACK)

	return tween
	
func unload_passengers() -> void:
	for child in get_children():
		if child is Passenger and child.target_floor == current_floor:
			var child_position = child.global_position
			remove_passenger(child)
			get_tree().root.add_child(child)
			child.global_position = child_position
			var child_tween = create_tween()
			child_tween.tween_property(child, "position", child.position + Vector2(-2000, 0), animation_speed).set_trans(Tween.TRANS_BACK)
			child_tween.finished.connect(child.queue_free)

func load_passengers(floor_node: Floor) -> void:
	# Call current floor
	# Take all the passengers
	# Tween them onto the elevator	
	for child in floor_node.get_children():
		if child is Passenger:
			var child_position = child.global_position
			floor_node.remove_child(child)
			add_passenger(child)
			child.global_position = child_position
			var child_tween = create_tween()
			child_tween.tween_property(child, "position", Vector2.ZERO + Vector2(randf_range(-25, 25), randf_range(-25, 25)), animation_speed).set_trans(Tween.TRANS_SINE)


func add_passenger(pas: Passenger) -> void:
	add_child(pas)

	capacity += pas.capacity
	weight += pas.weight

func remove_passenger(pas: Passenger) -> Passenger:
	remove_child(pas)

	capacity -= pas.capacity
	weight -= pas.weight

	return pas
