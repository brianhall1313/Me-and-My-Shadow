extends Area2D

var flipable:bool = false
var flipped:bool = false
# Called when the node enters the scene tree for the first time.
@export var wall:ToggleWall


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if flipable:
		if Input.is_action_just_pressed("interact"):
			if flipped:
				$switch_sprite.flip_v = not $switch_sprite.flip_v 
				flipped=false
				wall.reappear()
			else:
				$switch_sprite.flip_v = not $switch_sprite.flip_v 
				flipped=true
				wall.disappear()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("entered")
		flipable = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("exited")
		flipable = false
