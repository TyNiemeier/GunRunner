extends CharacterBody2D
class_name Boss

@export var speed = 50
@export var health = 1000
var damage = 10
var dead = false
var player_in_area = false
var player
var direction
var in_range = false
var take_health
var dying = false
var attacking = false
var skilluse = false
var swing = true
var skill = false
var summoning = false
var spirits = preload("res://scenes/entities/Enemy/summons.tscn")
@onready var rng = RandomNumberGenerator.new()
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var damage_numbers = $damage_numbers


func _physics_process(delta):
	if dying == false:
		if skilluse == false:
			if attacking == false:
				if summoning == false:
					if player_in_area == true:
						direction = player.position - position
						direction = direction.normalized() * speed
						velocity = direction
						sprite.play("Idle")
						if player.position < position:
							sprite.flip_h = true
							$Attack.scale.x *= -1
							$lookingrightcollision.disabled = true
							$lookingleftcollision.disabled = false
						if player.position > position:
							sprite.flip_h = false
							$Attack.scale.x *= -1
							$lookingrightcollision.disabled = false
							$lookingleftcollision.disabled = true
					else:
						velocity = Vector2.ZERO
						sprite.play("Moving")
				else:
					velocity = Vector2.ZERO
					sprite.play("Summoning")
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
	Damagenumbers.display_number(take_damage, damage_numbers.global_position)

func death():
	if dying == false:
		sprite.play("Death")
		dying = true
		$detection_area/CollisionShape2D.disabled = true
		$Hitbox/CollisionShape2D.disabled = true
		$lookingrightcollision.disabled = true
		$lookingleftcollision.disabled = true
		velocity = Vector2.ZERO
		Global.score += 1000000000000


func _on_attack_body_entered(body: Node2D) -> void:
	if body is Player:
		if swing == true:
			if attacking == false:
				attacking = true
				swing = false
				if not dying:
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
		nextattack()
	if sprite.animation == "Skill1":
		skilluse = false
		nextattack()
	if sprite.animation == "Summoning":
		summoning = false
		nextattack()
	if sprite.animation == "Death":
		queue_free()

func _on_skill_1_range_body_entered(body: Node2D) -> void:
	if body is Player:
		if skill == true:
			if skilluse == false:
				skilluse = true
				skill = false
				if not dying:
					sprite.play("Skill1")
	
func nextattack():
	var num = rng.randi_range(0,5)
	if num <= 2:
		swing = true
	if num > 2 and num <= 4 :
		skill = true
	if num >= 5:
		summoning = true
	
	
