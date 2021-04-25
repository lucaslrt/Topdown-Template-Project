extends Node
class_name StateMachine

#signal state_changed(state)

var character: Node2D = get_parent()
onready var current_state: State

func get_class():
	return "StateMachine"

func add_state(state: State):
	print("StateMachine -> state_received = ", state.name)
	self.add_child(state)
	
	state.connect("state_changed", self, "_on_state_changed")

func remove_state(state):
	remove_child(state)
	pass

func on_state_action_update(is_first: bool):
	current_state.update_action(is_first)
	pass

func on_state_action_finished():
	current_state.finish_action()

func _ready():
	print("StateMachine -> current_class = ", get_class())
	character = get_parent()
	print("StateMachine -> parent_class = ", character.name)
	
	
#	print("StateMachine -> current_state = ", current_state.name)
	pass

func _physics_process(delta):
	current_state.make_action(delta)
	pass

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
