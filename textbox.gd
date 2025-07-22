extends Control
class_name Textbox

@export var text_speed: float = 0.02
@export var sprite: Sprite2D
@export var rich_text: RichTextLabel 

var full_text: String = ""
var current_char: int = 0
var is_typing: bool = false

func _ready():
	rich_text.text = ""
	print("Textbox (should) work!")

# Main function to display text
func display_text(new_text: String):
	print("Displaying: ", new_text)
	full_text = new_text
	rich_text.text = full_text
	current_char = 0
	rich_text.visible_characters = 0
	is_typing = true
	_type_text()

func _type_text():
	while current_char < full_text.length() and is_typing:
		current_char += ceil(get_process_delta_time())
		rich_text.visible_characters = current_char
		await get_tree().create_timer(text_speed).timeout
	is_typing = false

func show_textbox():
	visible = true

func hide_textbox():
	visible = false
