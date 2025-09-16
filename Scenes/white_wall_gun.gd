extends AnimatedSprite2D

#use: place in level, add export timer so all associated guns fire simultaneously. 

@export var timer: Timer

func _ready() -> void:
	timer.connect("timeout",shoot)


func shoot() -> void:
	pass
