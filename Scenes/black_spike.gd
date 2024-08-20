extends Area2D



func _on_body_entered(body):
	print("BLACK SPIKE")
	if body.has_method("take_damage"):
		body.take_damage()
