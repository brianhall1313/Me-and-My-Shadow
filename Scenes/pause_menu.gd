extends PanelContainer

var paused:bool=false

signal continue_game
signal quit_game

func _ready() -> void:
	hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("back") and paused:
		continuing()


func pause() -> void:
	paused=true
	show()
	$VBoxContainer/VBoxContainer/continue.grab_focus()

func continuing() -> void:
	paused=false
	continue_game.emit()


func _on_continue_button_up() -> void:
	continuing()


func _on_quit_to_main_button_up() -> void:
	paused=false
	quit_game.emit()
