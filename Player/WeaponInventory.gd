extends Node

var inventory = []


func _ready():
	pass # Replace with function body.

func _has_item(item):
	
	pass

func update_inventory():
	for index in inventory.size():
		var slot = get_child(index)
		
	pass

func add_item(item) -> bool:
	if not inventory.has(item):
		inventory.append(item)
		return true
	
	print("Inventory -> Item already added.")
	return false

func remove_item(item):
	inventory.erase(item)
	pass
