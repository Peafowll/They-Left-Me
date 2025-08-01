extends Node

var items = {}

func _ready():
	var dir = DirAccess.open("res://Resources/Consumables")
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if file_name.ends_with(".tres"):
			var file_path = "res://Resources/Consumables/" + str(file_name)
			var item_resource = load(file_path)
			if item_resource:
				var item_name = item_resource.name
				items[item_name] = item_resource
		file_name = dir.get_next()
	dir.list_dir_end()
	print(items)

func get_item(name: String) -> Consumable:
	return items.get(name)
