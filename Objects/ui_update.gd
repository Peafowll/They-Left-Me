extends Control

@onready var energy_bar: ProgressBar = $EnergyBar
@onready var thirst_bar: ProgressBar = $ThirstBar
@onready var hunger_bar: ProgressBar = $HungerBar

@onready var canvas_layer = $TravelingTransition


# BUTTON
@export var travel_button : TextureButton



func _process(_delta: float) -> void:
	energy_bar.value = Player.energy
	hunger_bar.value = Player.hunger
	thirst_bar.value = Player.thirst

func _ready() -> void:
	canvas_layer.visible = false
	$SearchFoodButton.pressed.connect(func(): _on_search_button_pressed("food"))
	$SearchWaterButton.pressed.connect(func(): _on_search_button_pressed("water"))
	$SearchShelterButton.pressed.connect(func(): _on_search_button_pressed("shelter"))
	


	
func _on_search_button_pressed(tag : String):
	print("Cauti " + str(tag))
	World._search(tag)

func _on_travel_button_pressed() -> void:
	canvas_layer.visible = true
	World.nothing_found_modifier=1
	# Play footstep sound
	World.current_distance+=10
	if World.current_distance > World.current_location.size:
		World.current_distance = World.current_distance - World.current_location.size
		World.location_index+=1
	World.current_location = World.Locations[World.location_index]
	World._pass_time(12)
	await get_tree().create_timer(1.5).timeout
	canvas_layer.visible = false
	print(World.current_location.name)
	print(World.current_distance)
	print(World.day)
	print(World.hour)

func _on_quick_travel_button_pressed() -> void:
	canvas_layer.visible = true
	World.nothing_found_modifier=1
	# Play footstep sound
	World.current_distance+=10
	if World.current_distance > World.current_location.size:
		World.current_distance = World.current_distance - World.current_location.size
		World.location_index+=1
	World.current_location = World.Locations[World.location_index]
	World._pass_time(6)
	await get_tree().create_timer(1.5).timeout
	canvas_layer.visible = false
	print(World.current_location.name)
	print(World.current_distance)
	print(World.day)
	print(World.hour)
