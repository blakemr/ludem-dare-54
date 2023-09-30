class_name PassengerGenerator
extends Timer

signal new_passenger

func _ready() -> void:
	timeout.connect(create_passenger)

func create_passenger() -> void:
	new_passenger.emit(Passenger.new())

