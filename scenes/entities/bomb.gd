extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var blowup = false
var damage = 20

func _process(delta: float) -> void:
	if blowup == true:
		sprite.play("Explosion")
		if sprite.animation_finished:
			queue_free()

func _on_timer_timeout() -> void:
	blowup = true
