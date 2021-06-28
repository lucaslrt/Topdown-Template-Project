extends State

export(int) var MAX_SPEED = 80
export(int) var ACCELERATION = 500
export(int) var FRICTION = 500

func make_action(delta):
	_handle_movement(delta)
	pass

func _handle_movement(delta):
	var axis = _get_input_axis()

	if axis != Vector2.ZERO:
		character.velocity = character.velocity.move_toward(axis * MAX_SPEED, ACCELERATION * delta)
	else:
		character.velocity = character.velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	_handle_movement_animation(axis)
	character._apply_movement()
	_handle_input_actions()
	pass

func _get_input_axis() -> Vector2:
	var axis = Vector2.ZERO
	axis.x = int(Input.get_action_strength("ui_right")) - int(Input.get_action_strength("ui_left"))
	axis.y = int(Input.get_action_strength("ui_down")) - int(Input.get_action_strength("ui_up"))
	axis = axis.normalized()
	return axis

func _handle_movement_animation(axis):
	if axis != Vector2.ZERO:
		character.current_direction = axis
		character.animation_tree.set("parameters/Idle/blend_position", axis)
		character.animation_tree.set("parameters/Run/blend_position", axis)
		character.animation_state.travel("Run")
	else:
		character.animation_state.travel("Idle")
	pass

func _handle_input_actions():
	if Input.is_action_just_pressed("ui_dodge"):
		emit_signal("state_changed", "DodgeState")
	elif Input.is_action_just_pressed("ui_attack"):
		emit_signal("state_changed", "AttackState")
	pass
