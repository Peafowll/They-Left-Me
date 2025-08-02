extends Control

@onready var vbox = $Panel/VBoxContainer
@onready var item_row_default = $Panel/VBoxContainer/ItemRow



@onready var energy_bar: ProgressBar = $EnergyBar
@onready var thirst_bar: ProgressBar = $ThirstBar
@onready var hunger_bar: ProgressBar = $HungerBar


func _process(_delta: float) -> void:
	energy_bar.value = Player.energy
	hunger_bar.value = Player.hunger
	thirst_bar.value = Player.thirst

func _ready():
	item_row_default.hide()
	


func refresh_inventory():
	for object in vbox.get_children():
		if object != item_row_default:
			object.queue_free()
			
	for item in Player.inventory.keys():
		var amount = Player.inventory[item]
		print(item)
		var item_row = item_row_default.duplicate()
		var item_instance = item_row.get_node("ItemUI")
		
		#Changing the item name
		var item_name_label = item_instance.get_node("Label")
		item_name_label.text = "" # Clear the example text
		var item_name_label_placer : String = ""
		item_name_label_placer += "[center]"
		item_name_label_placer = item_name_label_placer + item.capitalize()
		item_name_label_placer +="[/center]"
		item_name_label.text += item_name_label_placer
		
		#Changing the item count
		var item_count_label = item_instance.get_node("CountLabel")
		item_count_label.text = ""
		var item_count_label_placer :String= "x"
		item_count_label_placer +=  str(amount)
		item_count_label.text = item_count_label_placer
		
		#Changing the item description
		var item_desc_label = item_instance.get_node("Description")
		item_desc_label.text = "" #Clear
		var item_desc_label_placer : String = ""
		item_desc_label_placer += ItemDatabase.get_item(item).description
		item_desc_label.text = item_desc_label_placer
		
		#Changing the name of the item
		var consume_button = item_instance.get_node("ConsumeButton")
		consume_button.set_meta("SourceItemName",item)
		item_row.show()
		vbox.add_child(item_row)

	# FOR THE LOVE OF ALL THAT IS HOLY , JUST ADD A CONSUMABLE OBJECT TO THIS SHIT



func toggle_inventory():
	visible = not visible
	if visible:
		refresh_inventory()
