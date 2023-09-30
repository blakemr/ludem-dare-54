class_name Passenger
extends Sprite2D

@export var weight: int = 5
@export var capacity: int = 1

var target_floor: int = 1
var start_floor: int = 1

func _ready() -> void:
	texture = load("res://icon.svg")

	target_floor = randi_range(0, Globals.number_of_floors-1)
	start_floor = randi_range(0, Globals.number_of_floors-1)
	
	while Globals.number_of_floors != 1 and start_floor == target_floor:
		start_floor = randi_range(0, Globals.number_of_floors-1)

	modulate = Globals.floor_colors[target_floor]

	var tween = create_tween()
	scale = Vector2.ZERO
	tween.tween_property(self, "scale", Vector2.ONE, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)