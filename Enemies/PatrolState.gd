extends Node2D

export(int) var patrol_range = 32

onready var start_position = global_position
onready var target_position = global_position
onready var timer = $Timer

func _update_target_position():
	var target_vector = Vector2(rand_range(-patrol_range, patrol_range), rand_range(-patrol_range, patrol_range))
	target_position = start_position + target_vector
	pass

func get_time_left():
	return timer.time_left

func start_patrol_timer(duration):
	timer.start(duration)
	pass

func _on_Timer_timeout():
	_update_target_position()
	pass # Replace with function body.
