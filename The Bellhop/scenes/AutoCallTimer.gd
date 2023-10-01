extends Timer

@export var auto_calls: Array[Floor]
var fl = 0
func on_timeout() -> void:
	var rand_floor = auto_calls.pick_random()

	while rand_floor.floor_number == fl:
		rand_floor = auto_calls.pick_random()

	fl = rand_floor.floor_number

	rand_floor.call_elevator.emit(rand_floor.call_position, rand_floor)
	wait_time = randf_range(2.5, 5)
