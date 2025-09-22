extends Node2D

#lazyish workaround, but apparently it works
@onready var lag_timer: Timer = $lag_timer

func _ready() -> void:
	lag_timer.start()
	var blast = 	Global.blast.instantiate()
	add_child(blast)
	blast.position = Vector2(-100,-100)
	blast.explode(true)
	var key = Global.key_particle.instantiate()
	add_child(key)
	key.position = Vector2(-100,-100)
	key.explode()
	var landing = Global.landing_particle.instantiate()
	add_child(landing)
	landing.position = Vector2(-100,-100)
	landing.explode()
	


func _on_lag_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
