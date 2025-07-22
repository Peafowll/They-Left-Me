extends Sprite2D

@export var parallax_strength: float = 0.02 
@export var smoothing: float = 5.0

var original_position: Vector2
var screen_center: Vector2

func _ready():
	original_position = position
	screen_center = get_viewport().get_visible_rect().size * 0.5

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var offset = (mouse_pos - screen_center) * parallax_strength
	
	var target_position = original_position - offset
	position = position.lerp(target_position, smoothing * delta)
