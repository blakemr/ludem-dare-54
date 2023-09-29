class_name Passenger
extends Sprite2D

@export var weight: int = 5
@export var capacity: int = 1

func _ready() -> void:
	texture = load("res://icon.svg")