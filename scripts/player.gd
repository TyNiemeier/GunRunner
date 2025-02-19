extends CharacterBody2D
class_name player

const SPEED = 100
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@export var playerId : int = 0
enum Directions {UP, DOWN, LEFT, RIGHT, RIGHTUP, LEFTUP, RIGHTDOWN, LEFTDOWN}
var facing : Directions = Directions.DOWN
var direction: Vector2 = Vector2.ZERO




func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()



	direction = Input.get_vector("p1_left", "p1_right", "p1_up", "p1_down")
	if direction.x < 0:
		sprite.play("p1_spearWalkUpLeft")
		facing = Directions.LEFT
	elif direction.x > 0:
		sprite.play("p1_spearWalkUpRight")
		facing = Directions.RIGHT
	elif direction.y > 0:
		sprite.play("p1_spearWalkDown")
		facing = Directions.DOWN
	elif direction.y < 0:
		sprite.play("p1_spearWalkUp")
		facing = Directions.UP
	elif direction.x == 0 && direction.y == 0:
		# Player is idle, check facing direction and choose appropriate idle animation
		if facing == Directions.LEFT:
			sprite.play("idle_left")
		elif facing == Directions.RIGHT:
			sprite.play("idle_right")
		elif facing == Directions.DOWN:
			sprite.play("idle_down")
		elif facing == Directions.UP:
			sprite.play("idle_up")
	velocity = direction * SPEED

#put player id back in input.get_axis when setting up two player
	# var hDirection = Input.get_axis("p1_left", "p1_right")
	# if hDirection:
	# 	velocity.x = hDirection * SPEED
	# 	if hDirection < 0:
	# 		#left
	# 		sprite.play("walk")
	# 		sprite.flip_h = true
	# 		facing = Directions.LEFT
	# 	else:
	# 		#right
	# 		sprite.play("walk")
	# 		sprite.flip_h = false
	# 		facing = Directions.RIGHT
	# else:
	# 	velocity.x = move_toward(velocity.x, 0, SPEED)


	# var vDirection = Input.get_axis("p1_up", "p1_down")
	# if vDirection:
	# 	velocity.y = vDirection * SPEED
	# 	if vDirection < 0:
	# 		#Up
	# 		sprite.play("walk")
	# 	else:
	# 		#down
	# 		sprite.play("walk")
	# else:
	# 	velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
