extends CharacterBody2D
class_name Enemy

@export var speed = 50

@export var health = 100
var damage
var dead = false
var player_in_area = false
var player
var direction
var in_range = false

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	dead = false

func _physics_process(delta):
	if !dead:
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

	if dead:
		$detection_area/CollisionShape2D.disabled = true

func _on_dectection_area_body_entered(body):
	if body is Player:
		player_in_area = true
		player = body

func _on_detection_area_body_exited(body):
	if body is Player:
		player_in_area = false

func take_damage(damage):
	health = health - damage
	if health <= 0 and !dead:
		death()

func death():
	dead = true
	queue_free()
