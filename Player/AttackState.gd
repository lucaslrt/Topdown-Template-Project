extends State
class_name AttackStateDecorator

var attack_list = {}

func make_action(delta):
	if attack_list.empty():
		finish_action()
	else:
		_handle_animation()
	pass

func _handle_animation():
	character.animation_state.travel("Punch")
	character.animation_tree.set("parameters/Punch/blend_position", character.current_direction)
	pass

func update_action(is_first: bool):
	
	var weapon_hitbox_collider = character.weapon_hitbox.get_node("CollisionShape2D")
	weapon_hitbox_collider.disabled = !is_first
	pass

func finish_action():
	print(self.name, " -> Fim da ação, alterando para MoveState.")
	emit_signal("state_changed", "MoveState")
