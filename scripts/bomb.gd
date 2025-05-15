extends Area2D
class_name Bomb

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var blowup = false
var bomb_damage = 100


func _process(_delta: float) -> void:
	if blowup == true:
		sprite.play("Explosion")


func _on_timer_timeout() -> void:
	blowup = true
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is Enemy:
			body.health -= bomb_damage
			print(body.health)
	


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "Explosion":
		queue_free()


func _on_body_entered(_body: Node2D) -> void:
	if blowup == true:
		pass
