extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	$InteractableSign.visible = active
	
func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("ui_interact"):
			get_tree().paused = true
			var dialog = Dialogic.start('Dialogue1')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)

func unpause(timeline_name):
	get_tree().paused = false

func _on_DialogueArea_body_entered(body):
	if body.name == 'Player':
		active = true
	pass # Replace with function body.


func _on_DialogueArea_body_exited(body):
	if body.name == 'Player':
		active = false
	pass # Replace with function body.

