extends GPUParticles2D

func explode(is_white:bool)->void:
	if not is_white:
		self_modulate = Color("Black")
	emitting = true


func _on_finished() -> void:
	queue_free()
