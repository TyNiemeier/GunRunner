extends Node2D
class_name Projectile

const speed = 100
@export var damage = 10

func _process(delta):
	position += transform.x * speed * delta



func _on_kill_timer_timeout():
	queue_free() # Replace with function body.
