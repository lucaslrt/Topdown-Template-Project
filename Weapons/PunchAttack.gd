extends Node2D

export(int) var weapon_damage = 1
export(PackedScene) var weapon_state_path

func _ready():
	pass
	
func _send_weapon_hitbox(character):
	var weapon_hitbox = get_node("Hitbox")
	character.add_weapon_hitbox(weapon_hitbox)
	character.weapon_hitbox.damage = weapon_damage
	pass

func _on_Area2D_body_entered(body):
	print("PunchAttack -> mandando o estado para ", body.name)
	body.state_machine.enable_state("PunchState")
	_send_weapon_hitbox(body)
	queue_free()
	pass # Replace with function body.
