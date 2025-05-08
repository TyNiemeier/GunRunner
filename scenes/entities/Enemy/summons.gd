extends CharacterBody2D
class_name Spirit


@export var speed = 80
@export var health = 100
var damage = 15

var appearing = true
var dead = false
var player_in_area = false
var player
var direction
var in_range = false
var take_health
var dying = false
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var detection : Area2D = $detection_area

func _physics_process(delta):
	if appearing == false:
		if dying == false:
			if player != null:
				direction = player.global_position - global_position
				direction = direction.normalized() * speed
				velocity = direction
				$CollisionShape2D.disabled = false
				$Hitbox/CollisionShape2D.disabled = false
				sprite.play("Idle")
		else:
			death()
	else:
		appear()
	move_and_collide(velocity * delta)
	
	var bodies = detection.get_overlapping_bodies()
	for body in bodies:
		if body is Player:
			player = body
	#enemy dies
	if health <= 0:
		death()
		

#enemy gets hit by playera
func take_damage(take_damage):
	health -= take_damage

func death():
	if dying == false:
		sprite.play("Death")
		dying = true
		$detection_area/CollisionShape2D.disabled = true
		$CollisionShape2D.disabled = true
		$Hitbox/CollisionShape2D.disabled = true
		velocity = Vector2.ZERO

func appear():
	velocity = Vector2.ZERO
	$CollisionShape2D.disabled = true
	$Hitbox/CollisionShape2D.disabled = true
	sprite.play("appear")

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "appear":
		appearing = false
