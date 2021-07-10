extends State
class_name AttackState

func make_action(delta):
	var selected_weapon: WeaponItem = character.inventory.selected_item
#	print("AttackState -> ", "fazendo a ação...")
	if selected_weapon != null:
		_handle_animation(selected_weapon.name)
	else:
		finish_action()
	pass

func _handle_animation(weapon_name):
	character.animation_state.travel(weapon_name)
	character.animation_tree.set("parameters/" + weapon_name + "/blend_position", character.current_direction)
	pass

func _unhandled_input(event):
	if event.is_action_pressed("ui_select_weapon_1"):
		select_weapon(0)
	elif event.is_action_pressed("ui_select_weapon_2"):
		select_weapon(1)
	elif event.is_action_pressed("ui_select_weapon_3"):
		select_weapon(2)
	pass

func select_weapon(position):
	var weapon: WeaponItem = character.inventory.find_selected_item(position)
	character.inventory.selected_item = weapon
	change_hitbox()
	character.stats.current_attack = weapon.name if weapon else "None"

func change_hitbox():
	var weapon: WeaponItem = character.inventory.selected_item
	if weapon != null:
		character.hitbox_pivot.remove_child(character.hitbox_pivot.get_child(0))
		var new_weapon_hitbox = weapon.hitbox_collision_area.instance()
		character.hitbox_pivot.add_child(new_weapon_hitbox)

func update_action(is_first: bool):
	var weapon_hitbox_collider = character.hitbox_pivot.get_child(0).get_child(0)
	weapon_hitbox_collider.disabled = !is_first
	pass

func finish_action():
#	print(self.name, " -> Fim da ação, alterando para MoveState.")
	emit_signal("state_changed", "MoveState")
