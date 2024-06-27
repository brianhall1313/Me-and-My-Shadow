extends Area2D




func _on_body_entered(_body):
	GlobalSignalBus.black_key_pickup.emit()
	queue_free()
