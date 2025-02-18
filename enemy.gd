extends CharacterBody2D
class_name enemy

@export var speed = 50
var dead = false
var player_in_area = false
var player

func _ready():
	dead = false

func _physics_process(delta):
	if !dead:
		$detection_area/CollisionShape2D.disabled = false
		if player_in_area:
			position += (player.position - position)
			$AnimatedSprite.play("Moving")
		else:
				$AnimatedSprite.play("Idle")
