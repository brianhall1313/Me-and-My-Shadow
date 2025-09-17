extends Area2D

@onready var sprite: AnimatedSprite2D = $sprite
const SPEED:int = 100
var direction:Vector2 = Vector2.RIGHT


func _ready() -> void:
	sprite.play("shot")

func _process(delta: float) -> void:
	position += delta*direction*SPEED

func shoot(pos:Vector2,rot:float) -> void:
	self.position = pos
	self.global_rotation = rot
	direction = direction.rotated(global_rotation)
	
