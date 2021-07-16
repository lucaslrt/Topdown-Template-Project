extends Control


func _ready():
	$VBoxContainer/StartButton.grab_focus()
	pass


func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/Scene1.tscn")
	pass # Replace with function body.


func _on_OptionsButton_pressed():
	var options = load("res://Menu/Options.tscn").instance()
	get_tree().current_scene.add_child(options)
	pass # Replace with function body.


func _on_ExitButton_pressed():
	get_tree().quit()
	pass # Replace with function body.
