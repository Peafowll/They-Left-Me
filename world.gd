extends Node2D


@export var day : int = 0
@export var hour : float = 0
const SEARCH_WEIGHT_BIAS = 3
var Locations : Array[Location] = []
var current_location
func _ready() -> void:
	Locations.append(load( "res://Resources/Locations/city.tres"))
	#print(Locations[0].loot_table.pool[0].name)
	current_location = Locations[0]
	var found = _search("food")
	print(found.name)
	
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



func _search(search_type: String)->Consumable:
	#checking if anything is found
	var chance_for_nothing = current_location.no_loot_chance
	var random = randi() % 100 + 1
	if(random<=chance_for_nothing):
		#print("You found nothing.")
		return null
		
	var found_item : Consumable
	var total_weight := 0
	var current_loot_pool = current_location.loot_table.pool; #array of items
	#at current location
	
	#getting total weight of all items
	for item in current_loot_pool:
		var weight = item.rarity
		if item.type == search_type: # doubling the added weight of items u want
			weight*= SEARCH_WEIGHT_BIAS
		total_weight+=weight
	#print("Greutate : ")
	#print(total_weight)
	
	#searching for items based on weight
	random=randf()*total_weight
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
	
	print("Found " + found_item.name+ ".")
	print(found_item.description)
	return found_item
