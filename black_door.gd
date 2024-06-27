extends Sprite2D

@onready var open_door = preload("res://door_black.png")
@onready var locked_door = preload("res://locked_black.png")

var player_in_area: bool = false
var unlocked: bool = false

func open():
	unlocked = true
	texture = open_door


func _on_interaction_area_body_entered(_area):
	player_in_area = true
	print("player has entered area(black door)")

func _on_interaction_area_body_exited(_area):
	player_in_area = false
	print("player has left area(black door)")
