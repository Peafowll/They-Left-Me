extends Control

@onready var vbox = $Panel/VBoxContainer
@onready var item_default = $Panel/VBoxContainer/Item


func _ready():
	item_default.hide()
	


func refresh_inventory():
	for object in vbox.get_children():
		if object != item_default:
			object.queue_free()
			
	for item in Player.inventory.keys():
		var amount = Player.inventory[item]
		print(item)
		var item_instance = item_default.duplicate()
		var item_label = item_instance.get_node("Label")
		item_instance.show()
		var item_text_row : String = ""
		item_text_row = item_text_row + item + " - " + str(amount)
		item_label.text += item_text_row
		vbox.add_child(item_instance)

func toggle_inventory():
	visible = not visible
	if visible:
		refresh_inventory()
