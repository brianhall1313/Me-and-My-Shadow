extends Node

signal player_damage
signal black_key_pickup
signal white_key_pickup


signal pushing(vector)

signal transition_done
signal transition_start

signal level_button_pressed(level)

func emit_player_damage() -> void:
	player_damage.emit()
func emit_black_key_pickup() -> void:
	black_key_pickup.emit()
func emit_white_key_pickup() -> void:
	white_key_pickup.emit()
func emit_pushing(vector) -> void:
	pushing.emit(vector)
func emit_transition_done() -> void:
	transition_done.emit()
func emit_transition_start() -> void:
	transition_start.emit()
func emit_level_button_pressed(level) -> void:
	level_button_pressed.emit(level)
