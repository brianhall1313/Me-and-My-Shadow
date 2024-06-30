extends Node2D

@onready var button_icon = preload("res://button.png")
@onready var locked_button_icon = preload("res://button_locked.png")
@onready var completed_button_icon = preload("res://button_complete.png")

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
	$"Control/VBoxContainer/level_grid/0".grab_focus()


func _on_back_button_up():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_0_button_up():
	Global.level = 0
	get_tree().change_scene_to_file("res://level_0.tscn")
	
func _on_1_button_up():
	Global.level = 1
	get_tree().change_scene_to_file("res://level_1.tscn")
	
func _on_2_button_up():
	Global.level = 2
	get_tree().change_scene_to_file("res://level_2.tscn")
	
func _on_3_button_up():
	Global.level = 3
	get_tree().change_scene_to_file("res://level_3.tscn")
	
func _on_4_button_up():
	Global.level = 4
	get_tree().change_scene_to_file("res://level_4.tscn")
