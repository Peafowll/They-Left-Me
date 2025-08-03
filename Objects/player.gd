extends Node2D
# Player Stats
@export_range(0,100) var hunger : float = 50
@export_range(0,100) var thirst : float = 100
@export_range(0,100) var energy : float = 100
@export_range(0,100) var sanity : float = 100

var rng = RandomNumberGenerator.new()
@export var inventory : Dictionary = {}
func _process(_delta: float) -> void:
	pass
	#hunger
	#TextBox.textbox.display_text(str(rng.randf_range(0,999999999999999)))

func remove_item(name : String):
	for item in inventory.keys():
		if item == name:
			if inventory[item] == 1:
				inventory.erase(item)
			else:
				inventory[item]-=1
				
func consume_item(name : String):
	remove_item(name)
	var item_object = ItemDatabase.get_item(name)
	energy += item_object.energy_fill
	thirst += item_object.thirst_fill
	hunger += item_object.food_fill
	sanity += item_object.sanity_fill
	
func drain_resources(m_hunger : int, m_thirst : int, m_energy : int, m_sanity : int):
	energy-=m_energy
	hunger-=m_hunger
	thirst-=m_thirst
	sanity-=m_sanity
