extends State


func make_action(delta):
#	print("Enemy ChaseState -> make_action")
	var player = character.playerDetectionZone.player
	if player != null:
		character._accelerate_twoards_point(player.global_position, delta)
	else:
		emit_signal("state_changed", "IdleState")
	pass

#func _accelerate_twoards_point(point, delta):
#	var direction = character.global_position.direction_to(point)
#	character.velocity = character.velocity.move_toward(character.direction * character.MAX_SPEED, character.ACCELERATION * delta)
#	character.sprite.flip_h = character.velocity.x < 0
#	pass
