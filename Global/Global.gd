extends Node

const levels:Array = [
	"res://Scenes/level_0.tscn",
	"res://Scenes/level_1.tscn",
	"res://Scenes/level_wall_jump.tscn",
	"res://Scenes/level_doors.tscn",
	"res://Scenes/level_2.tscn",
	"res://Scenes/level_wall_jump_spikes.tscn",
	"res://Scenes/level_3.tscn",
	"res://Scenes/level_4.tscn",
	"res://Scenes/level_5.tscn",
	"res://Scenes/level_6.tscn",
	"res://Scenes/level_hazardous_spring.tscn",
	"res://Scenes/level_7.tscn",
	"res://Scenes/level_8.tscn",
	"res://Scenes/level_9.tscn",
]


@onready var key_particle = preload("res://Animations/key_particle.tscn")
@onready var landing_particle = preload("res://Animations/landing_particle.tscn")
@onready var wipe = preload("res://Resources/wipe.tscn")

var in_transition:bool = false


var default_completed_level_log:Array= [false,false,false,false,false,false,false,false,false,false,false,false,false,false]
var default_open_level_log:Array = [true,false,false,false,false,false,false,false,false,false,false,false,false,false]
var completed_level_log:Array = [false,false,false,false,false,false,false,false,false,false,false,false,false,false]
var open_level_log:Array = [true,false,false,false,false,false,false,false,false,false,false,false,false,false]
var level:int = 0

var debug:bool = true


func _ready():
	GlobalSignalBus.connect("transition_done",unpause)
	GlobalSignalBus.connect("transition_start",pause)
	if ( len(default_completed_level_log) != len(default_open_level_log)) or ( len(default_completed_level_log) != len(completed_level_log)) or ( len(default_completed_level_log) != len(open_level_log)):
		print("level configuration error")

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
	set_level()

func load_default():
	completed_level_log=default_completed_level_log.duplicate()
	open_level_log=default_open_level_log.duplicate()

func pause():
	print("pause")
	get_tree().paused = true

func unpause():
	print("unpause")
	get_tree().paused = false


func load_level():
	get_tree().change_scene_to_file(levels[level])


func set_level():
	for i in range(len(levels)):
		if not open_level_log[i]:
			#-1 since the first false will be the next unavailable tile
			level = i-1
			print("level selected = ",str(i))
			return
	level = 0
