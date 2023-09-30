class_name Elevator
extends Node2D

signal over_capacity
signal over_weight

signal floor_arrived

@export var max_capacity: int = 5
@export var max_weight_limit: int = 100
@export var animation_speed = 1.0
var current_floor: int = 0

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

func call_recieved(pos: Vector2, floor_num: int) -> void:
	current_floor = floor_num
	move(pos)

func move(pos: Vector2) -> void:
	if moving: return

	var tween = create_tween()
	tween.tween_property(self, "position", pos, animation_speed).set_trans(Tween.TRANS_BACK)

	# Loading block
	moving = true
	
	await tween.finished
	unload_passengers()
	load_passengers()

	moving = false
	
func unload_passengers():
	for child in get_children():
		if child is Passenger:
			remove_passenger(child)
			get_tree().root.add_child(child)
			var child_tween = Tween.new()
			child_tween.tween_property(child, "global_position", child.global_position + Vector2(2000, 0), 2).set_trans(Tween.TRANS_BACK)
			child_tween.finished.connect(child.queue_free)

func load_passengers():
	pass

func add_passenger(pas: Passenger) -> void:
	add_child(pas)

	capacity += pas.capacity
	weight += pas.weight

func remove_passenger(pas: Passenger) -> Passenger:
	remove_child(pas)

	capacity -= pas.capacity
	weight -= pas.weight

	return pas
