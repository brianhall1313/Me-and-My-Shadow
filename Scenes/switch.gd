extends Area2D

var flipable:bool = false
var flipped:bool = false
# Called when the node enters the scene tree for the first time.
@export var wall:ToggleWall

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if flipable:
		if Input.is_action_just_pressed("interact"):
			if flipped:
				$switch_sprite.flip_v = false
				flipped=false
				wall.reappear()
			else:
				$switch_sprite.flip_v = true
				flipped=true
				wall.disappear()


func _on_body_entered(body: Node2D) -> void:
	flipable = true


func _on_body_exited(body: Node2D) -> void:
	flipable = false
