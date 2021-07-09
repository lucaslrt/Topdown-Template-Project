extends Resource
class_name Inventory

signal item_changed(indexes)
export(Array, Resource) var items = []

var selected_item: Resource = null setget set_selected_item

func find_selected_item(position) -> Resource:
	if items.empty() or position >= items.size():
		return null
	return items[position]

func set_selected_item(value: Resource):
	selected_item = value
	pass

func get_item_position(item) -> int:
	return items.find(item)

func add_item(item):
	if not items.has(item):
		items.append(item)
		#emit_signal("item_changed", items.count())
		print("Inventory -> [", item, "]")
	pass

func remove_item(item):
	var item_index = items.find(item)
	if item_index != -1:
		items.erase(item)
		emit_signal("item_changed", item_index)
	pass
