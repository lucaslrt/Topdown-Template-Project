extends Node

export(int) var max_health = 1 setget set_max_health
var current_health = max_health setget set_current_health
var current_attack = "None" setget set_current_attack
var attack_inventory_position = 0 setget set_current_attack

signal no_health
signal health_changed(value)
signal max_health_changed(value)
signal attack_changed(value)

func _ready():
	current_health = max_health
	pass

func set_max_health(value):
	max_health = value
	self.current_health = min(current_health, max_health)
	emit_signal("max_health_changed", max_health)
	pass

func set_current_health(value):
	current_health = value
	emit_signal("health_changed", current_health)
	if current_health <= 0:
		emit_signal("no_health")
	pass

func set_current_attack(value):
	current_attack = value if value else "None"
	emit_signal("attack_changed", current_attack)
	pass
