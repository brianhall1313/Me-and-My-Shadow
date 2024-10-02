extends Node2D

@onready var button_icon = preload("res://Textures/button.png")
@onready var locked_button_icon = preload("res://Textures/button_locked.png")
@onready var completed_button_icon = preload("res://Textures/button_complete.png")

@onready var level_grid = $Control/VBoxContainer/level_grid


# Called when the node enters the scene tree for the first time.
func _ready():
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


func _process(_delta):
	if Input.is_action_just_pressed("back"):
		exit()

func transition_to_level():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_right()

func exit():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_out()
	await GlobalSignalBus.transition_done
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func load_level() -> void:
	transition_to_level()
	await GlobalSignalBus.transition_done
	Global.load_level()


func _on_back_button_up() -> void:
	exit()


func _on_0_button_up() -> void:
	Global.level = 0
	load_level()
	
func _on_1_button_up() -> void:
	Global.level = 1
	load_level()
	
func _on_2_button_up() -> void:
	Global.level = 2
	load_level()
	
func _on_3_button_up() -> void:
	Global.level = 3
	load_level()
	
func _on_4_button_up() -> void:
	Global.level = 4
	load_level()

func _on_5_button_up() -> void:
	Global.level = 5
	load_level()

func _on_6_button_up() -> void:
	Global.level = 6
	load_level()


func _on_7_button_up() -> void:
	Global.level = 7
	load_level()


func _on_8_button_up() -> void:
	Global.level = 8
	load_level()



func _on_9_button_up() -> void:
	Global.level = 9
	load_level()


func _on_10_button_up() -> void:
	Global.level = 10
	load_level()


func _on_11_button_up() -> void:
	Global.level = 11
	load_level()


func _on_12_button_up() -> void:
	Global.level = 12
	load_level()


func _on_13_button_up() -> void:
	Global.level = 13
	load_level()
