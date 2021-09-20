extends Area2D


var active = false

func _process(delta):
	$InteractableSign.visible = active
	
func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("ui_interact") and active:
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
	pass

func _on_DialogueArea_body_exited(body):
	if body.name == 'Player':
		active = false
	pass

