extends State


func make_action(delta):
#	print("Enemy IdleState -> make_action")
	character.velocity = character.velocity.move_toward(Vector2.ZERO, character.FRICTION * delta)
	seek_player()
	if character.patrol_state.get_time_left() == 0:
		character.update_state()
	pass

func seek_player():
	if character.playerDetectionZone.can_see_player():
		print("Enemy IdleState -> player localizado.")
		emit_signal("state_changed", "ChaseState")
	pass
