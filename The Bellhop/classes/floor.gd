@tool
class_name Floor
extends Node2D

@export var size = Vector2(50, 50)
@export var call_position = Vector2.ZERO
@export var floor_indicator: Node
@export var size_reference: ReferenceRect
@export var call_reference: Marker2D

@export_range(0, 10) var floor_number: int = 0:
	set(value):
		if value >= 0 and value < Globals.number_of_floors:
			floor_indicator.modulate = Globals.floor_colors[value]

		else:
			print("Not a floor!")

		floor_number = value

func _ready() -> void:
	if size_reference:
		size = size_reference.size

	if call_reference:
		call_position = call_reference.global_position

	for child in get_children():
		if child is CollisionObject2D:
			child.input_event.connect(input_event)

func input_event(viewport: Node, event: InputEvent, shape_idx: int):
	pass