extends Node2D

@onready var collision_white = $floor_white/collision_white
@onready var shape_white = $floor_white/collision_white/shape_white
@onready var collision_black = $floor_black/collision_black
@onready var shape_black = $floor_black/collision_black/shape_black

var check_player_damaged:bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	shape_white.polygon = collision_white.polygon
	shape_black.polygon = collision_black.polygon
	connect_to_global_signal_bus()



func connect_to_global_signal_bus():
	GlobalSignalBus.connect("player_damage",player_damaged)
	GlobalSignalBus.connect("white_key_pickup",white_key)
	GlobalSignalBus.connect("black_key_pickup",black_key)

func _process(_delta):
	if check_player_damaged:
		#TODO:play death animation?
		get_tree().reload_current_scene()


func player_damaged():
	check_player_damaged = true

func white_key():
	$black_door.open()

func black_key():
	$white_door.open()
