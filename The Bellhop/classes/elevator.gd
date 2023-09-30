class_name Elevator
extends Node2D

signal over_capacity
signal over_weight

@export var max_capacity: int = 5
@export var max_weight_limit: int = 100
@export var animation_speed = 1.0

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

func move(pos: Vector2) -> void:
	if moving: return

	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(position.x, snappedf(pos.y, 50.0)), animation_speed).set_trans(Tween.TRANS_BACK)
	moving = true
	await tween.finished
	moving = false
	
func add_passenger(pas: Passenger) -> void:
	add_child(pas)

	capacity += pas.capacity
	weight += pas.weight

func remove_passenger(pas: Passenger) -> Passenger:
	remove_child(pas)

	capacity -= pas.capacity
	weight -= pas.weight

	return pas
