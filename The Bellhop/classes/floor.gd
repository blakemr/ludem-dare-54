@tool
class_name Floor
extends Node2D

@export var size = Vector2(50, 50)

@export_range(0, 10) var floor_number: int = 0:
	set(value):
		if value >= 0 and value < Globals.number_of_floors:
			modulate = Globals.floor_colors[value]

		else:
			print("Not a floor!")

		floor_number = value
