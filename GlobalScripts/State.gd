extends Node
class_name State

#const StateMachine = preload("res://GlobalScripts/StateMachine.tscn")
export(bool) var available = false

signal state_changed(state_name)
var character: Node2D

func _ready():
	if get_parent().get_class() == "StateMachine":
		character = get_parent().get_parent()
		#print(self.name, " -> State em ", character.name)
	pass

func _physics_process(delta):
	pass

func start_state():
	#print(self.name, " -> Começou o estado.")
	pass

func make_action(delta):
	print(self.name, " -> Fazendo a ação.")
	pass

func update_action(is_first: bool):
	pass

func finish_action():
	pass
