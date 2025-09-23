extends Node
@onready var bgm: AudioStreamPlayer = $BGM
@onready var jump: AudioStreamPlayer = $Jump
@onready var damage: AudioStreamPlayer = $Damage
@onready var key_pickup: AudioStreamPlayer = $Key_Pickup
@onready var descent: AudioStreamPlayer = $Descent
@onready var landing: AudioStreamPlayer = $Landing
@onready var click_on: AudioStreamPlayer = $Click_On
@onready var click_off: AudioStreamPlayer = $Click_Off
@onready var wall_jump: AudioStreamPlayer = $Wall_jump
@onready var shot_hit: AudioStreamPlayer = $Shot_Hit
@onready var shot_fired: AudioStreamPlayer = $Shot_Fired



# Called when the node enters the scene tree for the first time.
func _ready():
	if not Global.debug:
		bgm.play()
