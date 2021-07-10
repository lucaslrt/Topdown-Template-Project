extends Node2D

var punch_resource = preload("res://Weapons/Punch/Punch.tres")

func _on_Area2D_body_entered(character):
#	print("PunchAttack -> mandando o estado para ", character.name)
	character.state_machine.enable_state("PunchState")
	character.add_weapon(punch_resource)
	queue_free()
	pass # Replace with function body.
