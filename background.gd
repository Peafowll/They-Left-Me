extends Sprite2D

@export var parallax_strength: float = 0.02 
@export var smoothing: float = 5.0

var original_position: Vector2
var screen_center: Vector2

func _ready():
	original_position = position
	screen_center = get_viewport().get_visible_rect().size * 0.5
	TextBox.textbox.display_text("Whoa-oh-oh-oh-oh-oh-oh-oh-oh-oh Story of [color=#FF0000]UNDERTALE[/color] I fell from the light Talk? Or should I fight? Monster genocide This my [color=#FF0000]UNDERTALE! [/color]")
func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var _offset = (mouse_pos - screen_center) * parallax_strength
	
	var target_position = original_position - _offset
	position = position.lerp(target_position, smoothing * delta)
