extends CharacterBody2D
class_name MovableBlock


const BLOCK_MAX_VELOCITY = 200
const FRICTION = 1800


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if name == "black_block":
		gravity *= -1
	GlobalSignalBus.connect("push_black",push_black)
	GlobalSignalBus.connect("push_black",push_white)



func _physics_process(delta):
	velocity.x = 0
	handle_gravity(delta)
	handle_friction(delta)
	move_and_slide()



func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta


func handle_friction(delta):
		velocity.x = move_toward(velocity.x, 0, FRICTION*delta)


func push_black(value,bidi):
	if name == "black_block":
		push(value)
		if bidi:
			GlobalSignalBus.push_white.emit(value,false)



func push_white(value,bidi):
	if name == "white_block":
		push(value)
		if bidi:
			GlobalSignalBus.push_black.emit(value,false)


func push(value):
	velocity.x = value
	move_and_slide()
