extends AnimatedSprite2D

#use: place in level, add export timer so all associated guns fire simultaneously. 

@export var timer: Timer
@export var white: bool = true

func _ready() -> void:
	timer.connect("timeout",shoot)
	timer.start()
	play("idle")


func shoot() -> void:
	var new = Global.shot.instantiate()
	add_child(new)
	new.shoot(self.global_position,self.global_rotation,white)
