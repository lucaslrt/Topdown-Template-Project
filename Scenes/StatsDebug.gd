extends Label

var current_attack = "" setget set_attack

func _ready():
	self.current_attack = PlayerStats.current_attack
	PlayerStats.connect("attack_changed", self, "set_attack")
	pass

func set_attack(value):
	current_attack = value
	text = current_attack
	pass
