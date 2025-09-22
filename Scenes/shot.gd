extends Area2D

@onready var sprite: AnimatedSprite2D = $sprite
@onready var explosion_point: Marker2D = $explosion_point
const SPEED:int = 100
var direction:Vector2 = Vector2.RIGHT
var is_white:bool


func _ready() -> void:
	sprite.play("shot")

func _process(delta: float) -> void:
	global_position += delta*direction*SPEED

func shoot(pos:Vector2,rot:float,white:bool) -> void:
	self.global_position = pos
	self.global_rotation = rot
	is_white = white
	direction = direction.rotated(global_rotation)
	


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
	if body.get_parent().is_in_group('gun'):
		return
	var new = Global.blast.instantiate()
	get_parent().add_child(new)
	new.global_position = explosion_point.global_position
	new.explode(is_white)
	
	queue_free()
