extends Area2D



func _on_body_entered(body):
	print("SPIKE")
	if body.has_method("take_damage"):
		body.take_damage()
