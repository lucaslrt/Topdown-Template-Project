extends KinematicBody2D
class_name Character

var velocity = Vector2.ZERO
var current_direction = Vector2.DOWN

onready var state_machine: StateMachine = $StateMachine
onready var hurtbox = $Hurtbox

#var stats = PlayerStats

func _ready():
	pass
