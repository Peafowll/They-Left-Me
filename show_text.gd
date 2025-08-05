# In your main scene or create an autoload script
extends Node

var textbox: Textbox

func _ready():
	# Load and instance the textbox
	var textbox_scene = preload("res://Objects/textbox.tscn")
	textbox = textbox_scene.instantiate()
	add_child(textbox)

	textbox.position = Vector2(940, 900)

# WHAT THE ACTUAL FUCK IS WRONG WITH THIS TEXTBOX
# I HATE EVERYTHING 
