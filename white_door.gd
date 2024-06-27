extends Sprite2D

@onready var open_door = preload("res://door_white.png")
@onready var locked_door = preload("res://locked_white.png")

var player_in_area: bool = false
var unlocked: bool = false

func open():
	unlocked = true
	texture = open_door

func _on_interaction_area_body_entered(_area):
	player_in_area = true
	print("player has entered area(white door)")

func _on_interaction_area_body_exited(_area):
	player_in_area = false
	print("player has left area(white door)")
