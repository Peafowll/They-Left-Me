extends Sprite2D

@export var strength : float = 0.1
@export var smoothing : float = 5.0

var original_pos : Vector2
var center : Vector2

func _ready() -> void:
	original_pos = position
	center = get_viewport().get_visible_rect().size * 0.5
	DisplayServer.window_set_size(Vector2(1280,720))
	await get_tree().process_frame
	DisplayServer.window_set_position(Vector2(400,300))
	
func _process(delta: float) -> void:
	var mouse = get_global_mouse_position()
	var offset = (mouse - center) * strength
	
	var target = original_pos - offset
	position = position.lerp(target, smoothing * delta)
