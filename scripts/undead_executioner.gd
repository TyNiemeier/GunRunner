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
var swing = true
var skill = false
var summon = false
var spirits = preload("res://scenes/entities/Enemy/summons.tscn")
@onready var rng = RandomNumberGenerator.new()
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
		$Hitbox/CollisionShape2D.disabled = true
		$lookingrightcollision.disabled = true
		$lookingleftcollision.disabled = true
		velocity = Vector2.ZERO


func _on_attack_body_entered(body: Node2D) -> void:
	if body is Player:
		if swing == true:
			if attacking == false:
				attacking = true
				swing = false
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

func _on_skill_1_range_body_entered(body: Node2D) -> void:
	if body is Player:
		if skill == true:
			if skilluse == false:
				skilluse = true
				skill = false
				sprite.play("Skill1")
	
func nextattack():
	var num = rng.randi_range(0,10000)
	if num <= 2:
		swing = true
	if num > 2 and num <= 4 :
		skill = true
	if num >= 5:
		Summon()
		sprite.play("Summoning")
	
func Summon():
		var spirit = spirits.instantiate()
		var spirit2 = spirits.instantiate()
		var spirit3 = spirits.instantiate()
		get_parent().add_child(spirit)
		get_parent().add_child(spirit2)
		get_parent().add_child(spirit3)
		spirit.global_position = $Marker2D.global_position
		spirit2.global_position = $Marker2D2.global_position
		spirit3.global_position = $Marker2D3.global_position
		summon = false
	
	
