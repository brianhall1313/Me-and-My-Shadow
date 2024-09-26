extends StaticBody2D
class_name ToggleWall

func disappear() -> void:
	hide()
	$CollisionShape2D.disabled = true

func reappear() -> void:
	show()
	$CollisionShape2D.disabled = false
	
