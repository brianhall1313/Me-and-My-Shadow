extends Node2D

@onready var button_icon = preload("res://Textures/button.png")
@onready var locked_button_icon = preload("res://Textures/button_locked.png")
@onready var completed_button_icon = preload("res://Textures/button_complete.png")

@onready var level_grid: GridContainer = $Control/VBoxContainer/level_grid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignalBus.connect("level_button_pressed",load_level)
	for level in level_grid.get_children():
		if Global.completed_level_log[int(level.text)]:
			level.icon = completed_button_icon
		elif Global.open_level_log[int(level.text)]:
			level.icon = button_icon
		else:
			level.icon = locked_button_icon
			level.disabled = true
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_left()
	Global.set_level()
	var child = level_grid.get_children()[Global.level]
	child.grab_focus()


func _process(_delta) -> void:
	if Input.is_action_just_pressed("back"):
		exit()

func transition_to_level() -> void:
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_right()

func exit() -> void:
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_out()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func load_level(level) -> void:
	Global.level=level
	transition_to_level()
	await GlobalSignalBus.transition_done
	Global.load_level()


func _on_back_button_up() -> void:
	exit()
