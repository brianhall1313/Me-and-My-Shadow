extends Area2D

func do_key_stuff():
	AudioController.key_pickup.play()
	var new = Global.key_particle.instantiate()
	get_tree().get_current_scene().add_child(new)
	new.position = position
	new.explode()



func _on_body_entered(_body):
	GlobalSignalBus.white_key_pickup.emit()
	do_key_stuff()
	queue_free()
