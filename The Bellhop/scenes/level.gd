extends Node

# Test script
func _ready() -> void:
	randomize()
	$PassengerGenerator.new_passenger.connect(place_passenger)
	$PassengerGenerator.start()

func place_passenger(pas: Passenger) -> void:
	add_child(pas)
	pas.position = Vector2(randf_range(0, get_viewport().get_visible_rect().size.x), randf_range(0, get_viewport().get_visible_rect().size.y))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		$Elevator.move(event.position)
