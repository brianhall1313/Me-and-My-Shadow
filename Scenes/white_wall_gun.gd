extends AnimatedSprite2D

#use: place in level, add export timer so all associated guns fire simultaneously. 

@export var timer: Timer

func _ready() -> void:
	timer.connect("timeout",shoot)
	timer.start()


func shoot() -> void:
	var new = Global.shot.instantiate()
	get_parent().add_child(new)
	new.shoot(self.global_position,self.global_rotation)
