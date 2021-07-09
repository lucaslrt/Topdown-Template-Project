extends State
class_name AttackState

#var punch = get_parent().get_node("PunchState")

enum ATTACK_TYPE {HAND, SHOOT}

func make_action(delta):
	var selected_weapon: WeaponItem = character.inventory.selected_item
	print("AttackState -> ", "fazendo a ação...")
	if selected_weapon != null:
#		_apply_weapon_hitbox(selected_weapon.hitbox_collision_area)
		_handle_animation(selected_weapon.name)
	else:
		finish_action()
	pass

func _handle_animation(weapon_name):
	character.animation_state.travel(weapon_name)
	character.animation_tree.set("parameters/" + weapon_name + "/blend_position", character.current_direction)
	pass

func update_action(is_first: bool):
	var weapon_hitbox_collider = character.hitbox_pivot.get_child(0).get_child(0)
	weapon_hitbox_collider.disabled = !is_first
	pass

func finish_action():
	print(self.name, " -> Fim da ação, alterando para MoveState.")
	emit_signal("state_changed", "MoveState")
