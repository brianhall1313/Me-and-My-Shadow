extends CharacterBody2D


@export var movement_data: PlayerMovementData


const PUSH_FORCE = 20


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if name == "shadow":
		gravity *= -1
		

func _physics_process(delta):
	handle_gravity(delta)
	var direction = Input.get_axis("move_left", "move_right")
	handle_jump()
	handle_acceleration(direction,delta)
	handle_friction(direction,delta)
	handle_block()
	move_and_slide()



func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta


func handle_jump():
	if  is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = movement_data.jump_velocity
	else:
		if Input.is_action_just_released("jump"):
			if name == "shadow" and velocity.y > movement_data.jump_velocity/2:
				velocity.y = movement_data.jump_velocity/2
			elif name == "player" and velocity.y < movement_data.jump_velocity/2:
				velocity.y = movement_data.jump_velocity/2


func handle_acceleration(direction,delta):
	if direction != 0:
		velocity.x = move_toward(velocity.x,direction * movement_data.speed,movement_data.acceleration*delta)


func handle_friction(direction,delta):
	if direction==0:
		velocity.x = move_toward(velocity.x, 0, movement_data.friction*delta)



func take_damage():
	GlobalSignalBus.player_damage.emit()


func handle_block():
	if is_on_floor():
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var collision_block = collision.get_collider()
			if collision_block.name=="black_block":
				collision_block.push_black(velocity.x,true)
			elif collision_block.name == "white_block":
				collision_block.push_white(velocity.x,true)
	
