extends Node2D

@export var number_of_floors = Globals.number_of_floors

# Test script
func _ready() -> void:
	randomize()
	$PassengerGenerator.new_passenger.connect(place_passenger)
	$PassengerGenerator.start()

func place_passenger(pas: Passenger) -> void:
	var floors = $Floors.get_children()
	var current_floor = floors[pas.start_floor]
	var size = current_floor.size
	#var floor_size = floors[pas.start_floor].size
	#var floor_position = floors[pas.start_floor].global_position

	current_floor.add_child(pas)
	pas.position = size/2 + Vector2(randf_range(-size.x/2, size.x/2), randf_range(-size.y/2, size.y/2)) 

	#pas.global_position = floor_position + floor_size/2 + Vector2(randf_range(-floor_size.x/2, floor_size.x/2), randf_range(-floor_size.y/2, floor_size.y/2))
