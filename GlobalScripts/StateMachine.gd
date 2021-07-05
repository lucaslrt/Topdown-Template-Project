extends Node
class_name StateMachine

#signal state_changed(state)

var character: Node2D = get_parent()
onready var current_state: State

func _ready():
	#print("StateMachine -> current_class = ", get_class())
	character = get_parent()
	#print("StateMachine -> parent_class = ", character.name)
	pass

func _physics_process(delta):
	current_state.make_action(delta)
	pass

func get_class():
	return "StateMachine"

func enable_state(state_name: String):
	print("StateMachine -> state_enabled = ", state_name)
	for state in self.get_children():
		if state.name == state_name:
			state.available = true

func remove_state(state):
	remove_child(state)
	pass

func on_state_action_update(is_first: bool):
	current_state.update_action(is_first)
	pass

func on_state_action_finished():
	current_state.finish_action()

func change_state_by_name(state_name):
	for state in self.get_children():
		if state.name == state_name:
			current_state = state
			current_state.start_state()
			print("StateMachine -> novo current_state = ", current_state.name)
	pass

func _on_state_changed(state_name):
	print("StateMachine -> alterando para ", state_name)
	change_state_by_name(state_name)
	pass # Replace with function body.
