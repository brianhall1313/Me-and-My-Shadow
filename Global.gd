extends Node

@onready var key_particle = preload("res://key_particle.tscn")
@onready var landing_particle = preload("res://landing_particle.tscn")
@onready var wipe = preload("res://wipe.tscn")

var in_transition:bool = false


var default_completed_level_log:Array= [false,false,false,false,false,false,false,false,false,false]
var default_open_level_log:Array = [true,false,false,false,false,false,false,false,false,false]
var completed_level_log:Array = [false,false,false,false,false,false,false,false,false,false]
var open_level_log:Array = [true,false,false,false,false,false,false,false,false,false]
var level:int = 0


func _ready():
	GlobalSignalBus.connect("transition_done",unpause)
	GlobalSignalBus.connect("transition_start",pause)

func save_stuff():
	var save_data:Dictionary={"complete":completed_level_log.duplicate(),"open":open_level_log.duplicate()}
	SaveAndLoad.save_game(save_data)

func load_stuff():
	var save_data = SaveAndLoad.load_game()
	if save_data:
		completed_level_log = save_data["complete"].duplicate()
		open_level_log=save_data["open"].duplicate()
	else:
		load_default()

func load_default():
	completed_level_log=default_completed_level_log.duplicate()
	open_level_log=default_open_level_log.duplicate()

func pause():
	print("pause")
	get_tree().paused = true

func unpause():
	print("unpause")
	get_tree().paused = false
