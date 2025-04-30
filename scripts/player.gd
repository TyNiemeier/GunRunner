extends CharacterBody2D
class_name Player

const bulletPath = preload("res://scenes/entities/bullet.tscn")
const bomb_scene = preload("res://scenes/entities/bomb.tscn")
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@export var playerId : int = 0
@onready var dash_duration_timer = $DashDuration
@onready var dash_cool_down_timer = $DashCoolDown
# endum Action {IDLE, WALK, SPRINT, DASH, ATTACK}
enum Directions {UP, UPLEFT, UPRIGHT, DOWN, LEFT, RIGHT}
var facing : Directions = Directions.DOWN
var attackfacing
var direction: Vector2 = Vector2.ZERO
var SPEED = 150.0
var dashSpeed = 350.0
var canDash = true
var collision = true
var isSprinting = false
var currentWeapon = 0
var current_ammo = 7
var reloading = false



var isAttacking = false
var isIdle = false
var isWalking = false
var isDashing = false
var enemy_inattack_range = false
var allow_damage = true
var health = 100
var take_damage
var player_alive = true
var drop_bomb = true
var spear_damage = 20


#updates facing based on the direction
#used for animations
func _set_direction():
	if isAttacking == false:
		if isDashing == false:
			if direction.x < 0 and direction.y >= 0:
				facing = Directions.LEFT
				isWalking = true
			elif direction.x > 0 and direction.y >= 0:
				facing = Directions.RIGHT
				isWalking = true
			elif direction.y < 0 and direction.x == 0:
				facing = Directions.UP
				isWalking = true
			elif direction.y < 0 and direction.x < 0:
				facing = Directions.UPLEFT
				isWalking = true
			elif direction.y < 0 and direction.x > 0:
				facing = Directions.UPRIGHT
				isWalking = true
			elif direction.y > 0 and direction.x == 0:
				facing = Directions.DOWN
				isWalking = true
			if direction.x == 0 && direction.y == 0:
				isIdle = true
				isWalking = false
				isSprinting = false
			else:
				isIdle = false
		else:
			isSprinting = false
			isWalking = false
			isIdle = false
	else:
		isWalking = false
		isIdle = false



func _direction_suffix():
	if facing == Directions.LEFT:
		return "DownLeft"
	elif facing == Directions.RIGHT:
		return "DownRight"
	elif facing == Directions.DOWN:
		return "Down"
	elif facing == Directions.UP:
		return "Up"	
	elif facing == Directions.UPLEFT:
		return "UpLeft"	
	elif facing == Directions.UPRIGHT:
		return "UpRight"	
	

#sets animations for sprinting idle walk dash, etc
func _set_animation():

	#changes sprinting 
	if isSprinting && isAttacking == false:
		#sprinting for spear
		if currentWeapon == 0:
			sprite.play("p1_spearRun" + _direction_suffix())
		#sprinting for gun
		else:
			sprite.play("p1_gunRun" + _direction_suffix())
	#changes idle animations
	elif isIdle:
		#idle for spear
		if currentWeapon == 0:
			sprite.play("p1_idleSpear" + _direction_suffix())
		#idle for gun
		else:
			sprite.play("p1_idleGun" + _direction_suffix())
	elif isWalking:
		#walking for spear
		if currentWeapon == 0:
			sprite.play("p1_spearWalk" + _direction_suffix())
		#walking for gun
		else:
			sprite.play("p1_gunWalk" + _direction_suffix())
	elif isDashing:
			#dashing for spear
			if currentWeapon == 0:
				sprite.play("p1_spearDash" + _direction_suffix())
			#dashing for gun
			else:
				sprite.play("p1_gunDash" + _direction_suffix())
	if isAttacking:
			#attack for spear
		if currentWeapon == 0:
			sprite.play("p1_spearAttack" + _direction_suffix())
			#attack for gun
		else:
			if isSprinting:
				sprite.play("p1_gunAttackRun" + _direction_suffix())
			else:
				sprite.play("p1_gunAttack" + _direction_suffix())
			
#ISWALKING IS OVERIDING THE SPRINT POSSIBLY REWRITE SETTING WALKING TO TRUE
func dash():
	if (Input.is_action_just_pressed("dash") and canDash):
		isDashing = true
		canDash = false
		dash_duration_timer.start()
		dash_cool_down_timer.start()

	if isDashing:
		collision = false
func _on_dash_duration_timeout():
	isDashing = false
	collision = true
func _on_dash_cool_down_timeout():
	canDash = true

func _on_animated_sprite_2d_animation_finished():
	print(sprite.animation)
	if sprite.animation == "p1_spearAttack" or "p1_gunAttack "or "p1_gunAttackRun" + _direction_suffix():
		isAttacking = false

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
	if Input.is_action_pressed("p1_a"):
		SPEED = 200
		isSprinting = true
		#print(action)
	else:
		SPEED = 150
		isSprinting = false
	#Dash
	if isDashing:
		velocity = direction * dashSpeed
	else:
		velocity = direction * SPEED

	#Attack
	if Input.is_action_just_pressed("p1_l1"):
		isAttacking = true
		if currentWeapon == 0:
			spear_attack()
		if currentWeapon == 1:
			if current_ammo > 0:
				shoot()
			if current_ammo == 0:
				reload()
	$Aim.look_at((get_global_mouse_position()))

	#health doesnt go above health
	if health > 100:
		health = 100

	if Input.is_action_just_pressed("p1_bomb"):
		if drop_bomb == true:
			var bomb = bomb_scene.instantiate()
			get_tree().root.add_child(bomb)
			bomb.global_position = self.global_position
			drop_bomb = false
			$BombCoolDown.start()

	_set_direction()
	_set_animation()
	move_and_slide()
	dash()


#enemy or projectile hits player
func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		enemy_inattack_range = true
		take_damage = body.damage
		$PlayerHitbox/Hitboxtimer.start()
	if body is Projectile:
		if isDashing == false:
			enemy_inattack_range = true
			health -= body.damage
		body.queue_free()

#enemy leaves player's hitbox
func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body is Enemy:
		enemy_inattack_range = false
		$PlayerHitbox/Hitboxtimer.stop()

#player takes damage
func player_hit(take_damage):
	if enemy_inattack_range and allow_damage:
		health -= take_damage
		allow_damage = false
		$allow_damage.start()

#invisable / how long it takes until player is allowed to get damage
func _on_allow_damage_timeout() -> void:
	allow_damage = true # Replace with function body.


func _on_hitboxtimer_timeout() -> void:
	if isDashing == false:
		player_hit(take_damage)

#player picks up health item
func _on_player_hitbox_area_entered(area: Area2D) -> void:
	if area is Healing:
		if health < 100:
			health += area.heal
			area.queue_free()
			
func spear_attack():
	if isAttacking and currentWeapon == 0:
		if Directions.RIGHT:
			var bodies = $Rightattack.get_overlapping_bodies()
			for body in bodies:
				if body is Enemy:
					body.health -= spear_damage
					print('Rightattack')
		if Directions.LEFT:
			var bodies = $Leftattack.get_overlapping_bodies()
			for body in bodies:
				if body is Enemy:
					body.health -= spear_damage
					print('Leftattack')
		if Directions.UP:
			var bodies = $Upattack.get_overlapping_bodies()
			for body in bodies:
				if body is Enemy:
					body.health -= spear_damage
					print('Upattack')
		if Directions.DOWN:
			var bodies = $Downattack.get_overlapping_bodies()
			for body in bodies:
				if body is Enemy:
					body.health -= spear_damage
					print('Downattack')

func shoot():
	if isAttacking and currentWeapon == 1:
		var bullet = bulletPath.instantiate()
		get_parent().add_child(bullet)
		bullet.position = $Aim/Marker2D.global_position
		bullet.velocity = get_global_mouse_position() - bullet.position
		bullet.rotation = $Aim.rotation
		current_ammo -= 1

func reload():
	if reloading == false:
		reloading = true
		$Reload.start()
		

func _on_bomb_cool_down_timeout() -> void:
	drop_bomb = true
	$BombCoolDown.stop()

func _on_reload_timeout() -> void:
	reloading = false
	current_ammo = 7
