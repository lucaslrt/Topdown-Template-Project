extends State

const DODGE_SPEED = 125

func make_action(delta):
#	print(self.name, " -> Fazendo a ação")
	character.velocity = character.current_direction * DODGE_SPEED
	character._apply_movement()
	_handle_animation()
	pass

func _handle_animation():
	character.animation_state.travel("Dodge")
	character.animation_tree.set("parameters/Dodge/blend_position", character.current_direction)
	pass

func on_state_action_finished():
	print(self.name, " -> Finalizando a ação")
	character.velocity = Vector2.ZERO
	emit_signal("state_changed", "MoveState")
