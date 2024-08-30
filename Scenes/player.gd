extends CharacterBody2D

@onready var coyote_timer = $coyote_time
@onready var wall_jump_time = $wall_jump_time
@onready var animated_sprite = $animated_sprite



@export var movement_data: PlayerMovementData
var sprite_height:float = 16
var is_jumping:bool = false
var is_falling:bool = false
var wall_jump_available:bool = false
var floor_offset:float = sprite_height/2
var air_jumps:bool = true

const PUSH_FORCE = 20


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animated_sprite.play("idle")
	if name == "shadow":
		gravity *= -1
		

func _physics_process(delta):
	if (is_jumping or is_falling) and is_on_floor():
		is_jumping = false
		is_falling = false
		air_jumps = true
		landing_animation()
	handle_gravity(delta)
	var direction = Input.get_axis("move_left", "move_right")
	handle_jump()
	handle_wall_jump()
	handle_acceleration(direction,delta)
	handle_air_acceleration(direction,delta)
	handle_friction(direction,delta)
	handle_air_resistance(direction,delta)
	handle_block(direction)
	handle_animation(direction)
	var was_on_floor = is_on_floor()
	move_and_slide()
	wall_jump_available = is_on_wall_only()
	if wall_jump_available: 
		wall_jump_time.start()
	if was_on_floor and not is_on_floor() and not is_jumping:
		is_falling = true
		coyote_timer.start()



func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta


func handle_wall_jump():
	var wall_normal = get_wall_normal()
	#wall normal points away from the wall,this is the direction you want to go
	if is_on_wall_only() or wall_jump_available:
		if Input.is_action_just_pressed("move_left") and  wall_normal == Vector2.LEFT:
			velocity.x = wall_normal.x * movement_data.speed
			velocity.y = movement_data.jump_velocity
			is_jumping = true
		if Input.is_action_just_pressed("move_right") and wall_normal == Vector2.RIGHT:
			velocity.x = wall_normal.x * movement_data.speed
			velocity.y = movement_data.jump_velocity
			is_jumping = true
	


func handle_jump():
	if  is_on_floor() or coyote_timer.time_left > 0:
		if Input.is_action_just_pressed("jump"):
			is_jumping = true
			velocity.y = movement_data.jump_velocity
			AudioController.jump.play()
	elif not is_on_floor():
		if Input.is_action_just_pressed("jump") and (is_falling or is_jumping):
			if air_jumps:
				air_jumps = false
				velocity.y = movement_data.air_jump_velocity
		#shorten jump
		if Input.is_action_just_released("jump"):
			if name == "shadow" and velocity.y > movement_data.jump_velocity/2:
				velocity.y = movement_data.jump_velocity/2
			elif name == "player" and velocity.y < movement_data.jump_velocity/2:
				velocity.y = movement_data.jump_velocity/2


func handle_acceleration(direction,delta):
	if direction != 0 and is_on_floor():
		velocity.x = move_toward(velocity.x,direction * movement_data.speed,movement_data.acceleration*delta)

func handle_air_acceleration(direction,delta):
	if direction != 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x,direction * movement_data.speed,movement_data.air_acceleration*delta)

func handle_friction(direction,delta):
	if direction==0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.friction*delta)

func handle_air_resistance(direction,delta):
	if direction==0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.air_resistance*delta)




func take_damage():
	AudioController.damage.play()
	var new = Global.key_particle.instantiate()
	get_tree().get_current_scene().add_child(new)
	if name == "shadow":
		new.modulate = Color.BLACK
	new.position = position
	new.explode()
	GlobalSignalBus.player_damage.emit()




func handle_block(direction):
	if is_on_floor():
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var collision_block = collision.get_collider()
			if collision_block.name=="black_block" and collision_block.position.y>position.y:
				collision_block.push(Vector2(direction,0))
			elif collision_block.name == "white_block" and collision_block.position.y<position.y:
				collision_block.push(Vector2(direction,0))
	
func landing_animation():
	AudioController.landing.play()
	var new = Global.landing_particle.instantiate()
	get_tree().get_current_scene().add_child(new)
	new.position = position
	if name == "shadow":
		new.modulate = Color.BLACK
		new.rotation = 90
		new.position.y = position.y-floor_offset
	else:
		new.position.y = position.y+floor_offset
	
	new.explode()


func handle_animation(direction):
	if not is_on_floor():
		animated_sprite.play("jump")
		animated_sprite.flip_h = direction<0
		return
	if direction == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")
		animated_sprite.flip_h = direction<0
