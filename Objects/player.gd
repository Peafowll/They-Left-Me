extends Node2D
# Player Stats
@export_range(0,100) var hunger : float = 100
@export_range(0,100) var thirst : float = 100
@export_range(0,100) var energy : float = 100
@export_range(0,100) var sanity : float = 100

var rng = RandomNumberGenerator.new()
var inventory : Dictionary = {}
func _process(_delta: float) -> void:
	hunger-=0.01
	#TextBox.textbox.display_text(str(rng.randf_range(0,999999999999999)))
