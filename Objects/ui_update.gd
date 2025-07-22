extends Control

@onready var energy_bar: ProgressBar = $EnergyBar
@onready var thirst_bar: ProgressBar = $ThirstBar
@onready var hunger_bar: ProgressBar = $HungerBar

@onready var canvas_layer = $"../CanvasLayer"

func _process(_delta: float) -> void:
	energy_bar.value = Player.energy
	hunger_bar.value = Player.hunger
	thirst_bar.value = Player.thirst

func _ready() -> void:
	canvas_layer.visible = false

func _on_travel_button_pressed() -> void:
	canvas_layer.visible = true
	# Play footstep sound
	await get_tree().create_timer(2).timeout
	canvas_layer.visible = false
