extends Control



func _on_consume_button_pressed() -> void:
	Player.consume_item(get_node("ConsumeButton").get_meta("SourceItemName"))
	get_node("../../../..").refresh_inventory()
