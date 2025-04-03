extends CharacterBody2D
class_name Player


@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@export var playerId : int = 0
@onready var dash_duration_timer = $DashDuration
@onready var dash_cool_down_timer = $DashCoolDown
enum Directions {UP, DOWN, LEFT, RIGHT}
var facing : Directions = Directions.DOWN
var direction: Vector2 = Vector2.ZERO
var SPEED: int = 150.0
var is_dashing = false
var dash_speed = 350.0
var can_dash = true
var collision = true
var isSprinting = false
var currentWeapon = 0
var isAttacking = false
var isIdle = false
var isWalking = false
var enemy_inattack_range = false
var allow_damage = true
var health = 100
var take_damage
var player_alive = true

#updates facing based on the direction
#used for animations 
func _set_direction():
	if direction.x < 0:
		facing = Directions.LEFT
		isWalking = true
	elif direction.x > 0:
		facing = Directions.RIGHT
		isWalking = true
	elif direction.y > 0:
		facing = Directions.DOWN
		isWalking = true
	elif direction.y < 0:
		facing = Directions.UP
		isWalking = true
	if direction.x == 0 && direction.y == 0:
		isIdle = true
		isWalking = false
	else:
		isIdle = false
#sets animations for sprinting idle walk dash, etc
func _set_animation():
	#changes sprinting 
	if isSprinting:
		#sprinting for spear
		if currentWeapon == 0:
			if facing == Directions.LEFT:
				sprite.play("p1_spearRunDownLeft")
			elif facing == Directions.RIGHT:
				sprite.play("p1_spearRunDownRight")
			elif facing == Directions.DOWN:
				sprite.play("p1_spearRunDown")
			elif facing == Directions.UP:
				sprite.play("p1_spearRunUp")
		#sprinting for gun
		else:
			if facing == Directions.LEFT:
				sprite.play("p1_gunRunDownLeft")
			elif facing == Directions.RIGHT:
				sprite.play("p1_gunRunDownRight")
			elif facing == Directions.DOWN:
				sprite.play("p1_gunRunDown")
			elif facing == Directions.UP:
				sprite.play("p1_gunRunUp")


	#changes idle animations
	elif isIdle:
		#idle for spear
		
		if currentWeapon == 0:
			if facing == Directions.LEFT:
				sprite.play("p1_idleSpearDownLeft")
			elif facing == Directions.RIGHT:
				sprite.play("p1_idleSpearDownRight")
			elif facing == Directions.DOWN:
				sprite.play("p1_idleSpearDown")
			elif facing == Directions.UP:
				sprite.play("p1_idleSpearUp")
		#idle for gun
		else:
			if facing == Directions.LEFT:
				sprite.play("p1_idleGunDownLeft")
			elif facing == Directions.RIGHT:
				sprite.play("p1_idleGunDownRight")
			elif facing == Directions.DOWN:
				sprite.play("p1_idleGunDown")
			elif facing == Directions.UP:
				sprite.play("p1_idleGunUp")
	

	elif isWalking:
		#walking for spear
		
		if currentWeapon == 0:
			if facing == Directions.LEFT:
				sprite.play("p1_spearWalkDownLeft")
			elif facing == Directions.RIGHT:
				sprite.play("p1_spearWalkDownRight")
			elif facing == Directions.DOWN:
				sprite.play("p1_spearWalkDown")
			elif facing == Directions.UP:
				sprite.play("p1_spearWalkUp")
		#walking for gun
		else:
			if facing == Directions.LEFT:
				sprite.play("p1_gunWalkDownLeft")
			elif facing == Directions.RIGHT:
				sprite.play("p1_gunWalkDownRight")
			elif facing == Directions.DOWN:
				sprite.play("p1_gunWalkDown")
			elif facing == Directions.UP:
				sprite.play("p1_gunWalkUp")

func dash():
	if (Input.is_action_just_pressed("dash") and can_dash):
		is_dashing = true
		can_dash = false
		dash_duration_timer.start()
		dash_cool_down_timer.start()
	if is_dashing:
		collision = false
func _on_dash_duration_timeout():
	is_dashing = false
	collision = true
func _on_dash_cool_down_timeout():
	can_dash = true

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	if Input.is_action_just_pressed("p1_x"):
		currentWeapon += 1
	if currentWeapon >= 2:
		currentWeapon = 0

	direction = Input.get_vector("p1_left", "p1_right", "p1_up", "p1_down")
	#Movement
	velocity = direction * SPEED	
	#Sprint
	if Input.is_action_pressed("p1_a") && isIdle == false:
		SPEED = 200
		isSprinting = true
	else:
		SPEED = 150
		isSprinting = false
	#Dash
	if is_dashing:
		velocity = direction * dash_speed
	else:
		velocity = direction * SPEED
	#Attack
	# if Input.is_action_pressed("p1_l1"):
	# 	print("boom")
	# 	isAttacking = true
	# 	if facing == Directions.DOWN && isAttacking == true:
	# 		sprite.play("p1_spearDown")

	_set_direction()
	_set_animation()
	move_and_slide()
	dash()


func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		enemy_inattack_range = true
		player_hit(body.damage)


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body is Enemy or Projectile:
		enemy_inattack_range = false

func player_hit(take_damage):
	if enemy_inattack_range and allow_damage:
		health -= take_damage
		allow_damage = false
		$allow_damage.start()
		print(health)


func _on_allow_damage_timeout() -> void:
	allow_damage = true # Replace with function body.
