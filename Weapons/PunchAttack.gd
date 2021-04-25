extends Node2D

export(int) var weapon_damage = 1

func _ready():
	pass

func _send_state(character):
	var state = get_node("PunchState")
	remove_child(state)
	character.add_state(state)
	pass
	
func _send_weapon_hitbox(character):
	var weapon_hitbox = get_node("Hitbox")
	character.add_weapon_hitbox(weapon_hitbox)
	character.weapon_hitbox.damage = weapon_damage
	pass

func _on_Area2D_body_entered(body):
	print("PunchAttack -> mandando o estado para ", body.name)
	_send_state(body)
	_send_weapon_hitbox(body)
	queue_free()
	pass # Replace with function body.
