extends CharacterBody2D

var speed = 300
var damage = 20

func _physics_process(delta: float) -> void:
	move_and_collide((velocity.normalized() * delta * speed))


func _on_despawn_timeout() -> void:
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		area.take_damage(damage)
		queue_free()
