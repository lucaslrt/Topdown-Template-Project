extends State

export(int) var patrol_range = 32

onready var start_position = character.global_position
onready var target_position = character.global_position
onready var timer = $Timer

func _ready():
	pass

func make_action(delta):
#	print("Enemy PatrolState -> make_action")
	if get_time_left() == 0:
		character.update_state()
	character._accelerate_twoards_point(target_position, delta)
	if character.global_position.distance_to(target_position) <= character.PATROL_TARGET_RANGE:
		emit_signal("state_changed", "IdleState")
	pass

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
#	print(get_parent().get_parent().name, "PatrolState -> timeout")
	_update_target_position()
	pass # Replace with function body.
