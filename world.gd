extends Node2D


@export var day : int = 0
@export var hour : float = 0
@export var nothing_found_modifier = 1
const SEARCH_WEIGHT_BIAS = 3
const SEARCH_SHELTER_BIAS = 5

@export var Locations : Array[Location] = []
@export var current_location : Location
@export var location_index : int = 0
@export var current_distance : int

func _ready() -> void:
	var folder_path = "res://Resources/Locations/"
	var dir = DirAccess.open(folder_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				Locations.append(load(folder_path + file_name))
			file_name = dir.get_next()
		dir.list_dir_end()
	if Locations.size() > 0:
		Locations.shuffle()
	#print(Locations[0].loot_table.pool[0].name)
	current_location = Locations[location_index]
	print("Current location : " + current_location.name)
	print("Necessary background : " + current_location.background_image)
	
	#below is testing for chances based on weight
	#var results : Dictionary = {
		#"nothing" : 0,
		#"packaged sandwich" : 0,
		#"water bottle" : 0,
		#"can of soda" : 0,
		#"bag of chips":0
	#}
	#var try = 0
	#while(try<100):
		#var result = _search("food")
		#if(result==null):
			#results["nothing"]=results["nothing"]+1
		#else:
			#results[result.name]=results[result.name]+1
		#try=try+1
		#print(results)



func _search(search_type: String):
	#checking if anything is found
	if _roll_for_nothing():
		return null

	if _roll_for_shelter(search_type):
		return "shelter"
	
	return _roll_for_items(search_type)



func _roll_for_nothing():
	var chance_for_nothing = current_location.no_loot_chance
	var random = randi() % 100 + 1
	if(random<=chance_for_nothing*nothing_found_modifier):
		TextBox.textbox.display_text("You found nothing.")
		return true

func _roll_for_shelter(search_type):
	var chance_for_shelter= current_location.shelter_chance
	if (search_type=="shelter"):
		chance_for_shelter *= SEARCH_SHELTER_BIAS
	var random = randi() % 100 +1
	if(random<=chance_for_shelter):
		nothing_found_modifier+=1
		var text_to_display : String = "You found shelter."
		text_to_display = _resource_amount_left_display(text_to_display)	
		TextBox.textbox.display_text(text_to_display)
		return true
	return false

func _roll_for_items(search_type):
	var found_item : Consumable = null
	var total_weight := 0
	var current_loot_pool = current_location.loot_table.pool; #array of items
	#at current location
	
	#getting total weight of all items
	for item in current_loot_pool:
		var weight = item.rarity
		if item.type == search_type: #adding weight of items searched for
			weight*= SEARCH_WEIGHT_BIAS
		total_weight+=weight
	#print("Greutate : ")
	#print(total_weight)
	
	#searching for items based on weight
	var random=randf()*total_weight
	var current_weight = 0
	for item in current_loot_pool:
		var weight = 0
		if item.type == search_type:
			weight = item.rarity  * SEARCH_WEIGHT_BIAS
		else:
			weight = item.rarity
		current_weight += weight
		if random <= current_weight:
			found_item = item
			break;
	
	nothing_found_modifier+=1
	var text_to_display : String = "You found [color=Moccasin]" +found_item.name+ "[/color]. \n"
	text_to_display += found_item.description
	text_to_display=_resource_amount_left_display(text_to_display)
	TextBox.textbox.display_text(text_to_display)
	print(current_location.no_loot_chance*nothing_found_modifier)
	
	if Player.inventory.has(found_item.name):
		Player.inventory[found_item.name]+=1
	else:
		Player.inventory[found_item.name]=1
	print(Player.inventory)
	return found_item
	
func _pass_time(time : float):
	hour+=time
	if hour >= 24:
		day+=1
		hour=hour-24
		
func _resource_amount_left_display(text : String) -> String:
	if current_location.no_loot_chance*nothing_found_modifier>=100:
		return text + "\nThis area seems to have [color=red]nothing[/color] left to search for."
	else:
		return text + "\nThis area's resources have [color=Lightcoral]depleted[/color]."
