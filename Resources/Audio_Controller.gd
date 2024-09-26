extends Node
@onready var bgm: AudioStreamPlayer = $BGM
@onready var jump: AudioStreamPlayer = $Jump
@onready var damage: AudioStreamPlayer = $Damage
@onready var key_pickup: AudioStreamPlayer = $Key_Pickup
@onready var descent: AudioStreamPlayer = $Descent
@onready var landing: AudioStreamPlayer = $Landing
@onready var click_on: AudioStreamPlayer = $Click_On
@onready var click_off: AudioStreamPlayer = $Click_Off



# Called when the node enters the scene tree for the first time.
func _ready():
	if not Global.debug:
		bgm.play()
