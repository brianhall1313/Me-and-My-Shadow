extends CharacterBody2D
class_name MovableBlock


const ACCELERATION = 2000
const SPEED = 100
const FRICTION = 2000


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_being_pushed:bool = false
var push_vector:Vector2 = Vector2.ZERO

func _ready():
	if name == "black_block":
		gravity *= -1
	GlobalSignalBus.connect("pushing",pushing)



func _physics_process(delta):
	
	handle_gravity(delta)
	handle_friction(delta)
	handle_acceleration(push_vector,delta)
	if is_being_pushed:
		print(velocity, " " , name , " other data: ", delta)
	move_and_slide()
	is_being_pushed = false
	velocity = Vector2.ZERO
	push_vector = Vector2.ZERO


func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta


func handle_friction(delta):
	if push_vector == Vector2.ZERO:
		velocity.x = move_toward(velocity.x, 0, FRICTION*delta)

func handle_acceleration(direction,delta):
	if direction != Vector2.ZERO:
		velocity.x = move_toward(velocity.x,direction.x * SPEED, ACCELERATION * delta)


func push(value):
	#velocity.x = value
	#move_and_slide()
	GlobalSignalBus.pushing.emit(value)

func pushing(vector):
	is_being_pushed = true
	push_vector = vector
