extends Control

@onready var energy_bar: ProgressBar = $EnergyBar
@onready var thirst_bar: ProgressBar = $ThirstBar
@onready var hunger_bar: ProgressBar = $HungerBar

@onready var canvas_layer = $"../TravelingTransition"

#@onready var food_search_button : Button = $SearchFoodButton
#@onready var water_search_button : Button = $SearchWaterButton
#@onready var shelter_search_button : Button = $SearchShelterButton


func _process(_delta: float) -> void:
	energy_bar.value = Player.energy
	hunger_bar.value = Player.hunger
	thirst_bar.value = Player.thirst

func _ready() -> void:
	canvas_layer.visible = false
	$SearchFoodButton.pressed.connect(func(): _on_search_button_pressed("food"))
	$SearchWaterButton.pressed.connect(func(): _on_search_button_pressed("water"))
	$SearchShelterButton.pressed.connect(func(): _on_search_button_pressed("shelter"))

func _on_travel_button_pressed() -> void:
	canvas_layer.visible = true
	# Play footstep sound
	await get_tree().create_timer(2).timeout
	canvas_layer.visible = false
	
func _on_search_button_pressed(tag : String):
	print("Cauti " + str(tag))
	World._search(tag)
