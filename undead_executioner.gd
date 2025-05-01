extends CharacterBody2D

@export var speed = 50
@export var health = 100


var dead = false
var player_in_area = false
var player
var direction
var in_range = false
var take_health
var dying = false
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	if dead == false:
		if player_in_area && in_range == false:
			direction = player.position - position
			direction = direction.normalized() * speed
			velocity = direction
			sprite.play("Moving")
			if player.position < position:
				sprite.flip_h = true
			if player.position > position:
				sprite.flip_h = false
		else:
			velocity = Vector2.ZERO
			sprite.play("Idle")
	move_and_collide(velocity * delta)
	
	#enemy dies
	if health <= 0:
		death()
#chase player if player is in range
func _on_dectection_area_body_entered(body):
	if body is Player:
		player_in_area = true
		player = body

#stops chasing when player leaves range
func _on_detection_area_body_exited(body):
	if body is Player:
		player_in_area = false


#enemy gets hit by playera
func take_damage(take_damage):
	health -= take_damage

func death():
	if dying == false:
		sprite.play("death")
		dying = true
		$detection_area/CollisionShape2D.disabled = true
		$CollisionShape2D.disabled = true
	
