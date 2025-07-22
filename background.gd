extends Sprite2D

@export var parallax_strength: float = 0.02  # How much the background moves (0.0 to 1.0)
@export var smoothing: float = 5.0  # How smooth the movement is

var original_position: Vector2
var screen_center: Vector2

func _ready():
	original_position = position
	screen_center = get_viewport().get_visible_rect().size * 0.5

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	
	# Calculate offset from screen center
	var offset = (mouse_pos - screen_center) * parallax_strength
	
	# Smoothly move to the target position
	var target_position = original_position - offset
	position = position.lerp(target_position, smoothing * delta)
