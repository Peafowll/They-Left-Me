extends Control

@onready var energy_bar: ProgressBar = $EnergyBar
@onready var thirst_bar: ProgressBar = $ThirstBar
@onready var hunger_bar: ProgressBar = $HungerBar

func _process(delta: float) -> void:
	energy_bar.value = Player.energy
	hunger_bar.value = Player.hunger
	thirst_bar.value = Player.thirst
