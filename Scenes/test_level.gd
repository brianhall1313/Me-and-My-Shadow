extends Node2D

@export var level:int


@onready var black_door = $black_door
@onready var white_door = $white_door
@onready var bottom_background = $bottom_background
@onready var top_background = $top_background
@onready var pause_menu = $pause_menu

var check_player_damaged:bool = false
var is_paused:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_to_global_signal_bus()
	top_background.show()
	bottom_background.show()
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_left()



func connect_to_global_signal_bus():
	GlobalSignalBus.connect("player_damage",player_damaged)
	GlobalSignalBus.connect("white_key_pickup",white_key)
	GlobalSignalBus.connect("black_key_pickup",black_key)

func _process(_delta):
	if check_player_damaged:
		exit()
		await GlobalSignalBus.transition_done
		get_tree().reload_current_scene()
	if black_door.player_in_area and white_door.player_in_area:
		if black_door.unlocked and white_door.unlocked:
			if Input.is_action_just_released("interact"):
				Global.completed_level_log[self.level] = true
				if self.level +1 < len(Global.open_level_log):
					Global.open_level_log[self.level +1] = true 
				AudioController.descent.play()
				Global.save_stuff()
				exit()
				await GlobalSignalBus.transition_done
				get_tree().change_scene_to_file("res://Scenes/level_select.tscn")
	if Input.is_action_just_pressed("back"):
		if is_paused:
			close_pause()
		else:
			open_pause()


func player_damaged():
	check_player_damaged = true

func white_key():
	$black_door.open()

func black_key():
	$white_door.open()

func exit():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_right()

func popup_transition_one():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_right()

func popup_transition_two():
	var new = Global.wipe.instantiate()
	add_child(new)
	new.wipe_left()

func open_pause():
	is_paused = true
	popup_transition_one()
	await GlobalSignalBus.transition_done
	pause_menu.show()
	popup_transition_two()
	await GlobalSignalBus.transition_done
	Global.pause()
	$pause_menu/VBoxContainer/VBoxContainer/continue.grab_focus()
	

func close_pause():
	popup_transition_one()
	await GlobalSignalBus.transition_done
	pause_menu.hide()
	popup_transition_two()
	await GlobalSignalBus.transition_done
	Global.unpause()
	is_paused = false


func _on_quit_to_main_button_up():
	get_tree().change_scene_to_file("res://Scenes/level_select.tscn")
	
