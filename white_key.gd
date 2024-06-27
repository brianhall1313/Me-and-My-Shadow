extends Area2D



func _on_body_entered(_body):
	GlobalSignalBus.white_key_pickup.emit()
	queue_free()
