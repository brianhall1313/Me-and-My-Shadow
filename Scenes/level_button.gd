extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_button_up() -> void:
	GlobalSignalBus.emit_level_button_pressed(int(text))
