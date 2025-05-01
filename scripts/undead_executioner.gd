extends CharacterBody2D

@export var speed = 50
@export var health = 1
var dead = false
var player_in_area = false
var player
var direction
var in_range = false
var take_health
var dying = false
var attacking = false
var skilluse = false
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	if dying == false:
		if skilluse == false:
			if attacking == false:
				if player_in_area == true:
					direction = player.position - position
					direction = direction.normalized() * speed
					velocity = direction
					sprite.play("Idle")
					if player.position < position:
						sprite.flip_h = true
						$Attack.scale.x *= -1
					if player.position > position:
						sprite.flip_h = false
						$Attack.scale.x *= -1
				else:
					velocity = Vector2.ZERO
					sprite.play("Moving")
			else:
				velocity = Vector2.ZERO
		else:
			velocity = Vector2.ZERO 
	move_and_collide(velocity * delta)
	
	#enemy dies
	if health <= 0:
		death()
		
#chase player if player is in range
func _on_detection_area_body_entered(body):
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
		sprite.play("Death")
		dying = true
		$detection_area/CollisionShape2D.disabled = true
		$CollisionShape2D.disabled = true
		$Hitbox/CollisionShape2D.disabled = true
		velocity = Vector2.ZERO


func _on_attack_body_entered(body: Node2D) -> void:
	if body is Player:
		if attacking == false:
			attacking = true
			sprite.play("Attacking")
		

func attack(damage):
	if attacking == true:
		var bodies = $Attack.get_overlapping_bodies()
		for body in bodies:
			if body is Player:
				body.health -= damage
	if skilluse == true:
		var bodies = $Skill1_range.get_overlapping_bodies()
		for body in bodies:
			if body is Player:
				body.health -= damage


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "Attacking":
		attacking = false
	if sprite.animation == "Skill1":
		skilluse = false


func _on_skill_1_range_body_entered(body: Node2D) -> void:
	if body is Player:
		if skilluse == false:
			skilluse = true
			sprite.play("Skill1")
