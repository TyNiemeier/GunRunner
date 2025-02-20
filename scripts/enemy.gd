extends CharacterBody2D
class_name enemy

@export var speed = 50

@export var health = 100
var damage
var dead = false
var player_in_area = false
var Player

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	dead = false

func _physics_process(delta):
	if !dead:
		if player_in_area:
			position += (Player.position - position) / speed
			sprite.play("Moving")
			if Player.position < position:
				sprite.filp_h = true
		else:
			sprite.play("Idle")

	if dead:
		$detection_area/CollisionShape2D.disabled = true

func _on_dectection_area_body_entered(body):
	if body is player:
		player_in_area = true
		Player = body

func _on_detection_area_body_exited(body):
	if body is player:
		player_in_area = false

func take_damage(damage):

	health = health - damage
	if health <= 0 and !dead:
		death()

func death():
	dead = true
	queue_free()
