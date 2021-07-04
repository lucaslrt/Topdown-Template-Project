extends Label

var current_attack = 0 setget set_current_attack

func _ready():
	self.current_attack = PlayerStats.current_attack
	PlayerStats.connect("attack_changed", self, "set_current_attack")
	pass

func set_current_attack(value):
	current_attack = value
	pass
