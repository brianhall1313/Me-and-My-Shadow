extends Area2D

@onready var sprite: AnimatedSprite2D = $sprite
const SPEED:int = 100
var direction:Vector2 = Vector2.RIGHT


func _ready() -> void:
	sprite.play("shot")

func _process(delta: float) -> void:
	global_position += delta*direction*SPEED

func shoot(pos:Vector2,rot:float) -> void:
	self.global_position = pos
	self.global_rotation = rot
	direction = direction.rotated(global_rotation)
	


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
	if body.get_parent().is_in_group('gun'):
		return
	queue_free()
