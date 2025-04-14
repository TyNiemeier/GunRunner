extends Area2D

var blowup = false
var damage = 20

func _on_timer_timeout() -> void:
	blowup = true
