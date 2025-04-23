extends CharacterBody2D

var speed = 300
var damage = 10

func _physics_process(delta: float) -> void:
	
	var collision_info = move_and_collide((velocity.normalized() * delta * speed))
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.health -= damage
		queue_free()


func _on_despawn_timeout() -> void:
	queue_free()
