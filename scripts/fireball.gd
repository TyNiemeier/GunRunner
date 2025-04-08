extends Node2D


const speed = 100

func _process(delta):
	position += transform.x * speed * delta

func _on_kill_timer_timeout():
	queue_free() # Replace with function body.
