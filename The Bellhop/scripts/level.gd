extends Node

# Test script
func _ready() -> void:
	randomize()
	$PassengerGenerator.new_passenger.connect(place_passenger)
	$PassengerGenerator.start()

func place_passenger(pas: Passenger) -> void:
	add_child(pas)
	var floors = $Floors.get_children()
	var floor_size = floors[pas.target_floor].size
	var floor_position = floors[pas.start_floor].global_position
	pas.global_position = floor_position + floor_size/2 + Vector2(randf_range(-floor_size.x/2, floor_size.x/2), randf_range(-floor_size.y/2, floor_size.y/2))
