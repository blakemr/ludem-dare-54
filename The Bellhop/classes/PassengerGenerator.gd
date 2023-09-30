class_name PassengerGenerator
extends Timer

signal new_passenger
@export var floor_textures: Array[Texture]

func _ready() -> void:
	timeout.connect(create_passenger)

func create_passenger() -> void:
	var new_pass = Passenger.new()
	if new_pass.target_floor >= 0 and new_pass.target_floor < len(floor_textures):
		new_pass.texture = floor_textures[new_pass.target_floor] 

	new_passenger.emit(new_pass)

