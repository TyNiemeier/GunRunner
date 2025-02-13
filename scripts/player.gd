extends CharacterBody2D
class_name Player

#Variables:
var speed: int=10000
var direction: Vector2 = Vector2.ZERO
var isAttacking = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	#define direction
	direction = Input.get_vector("p1_left","p1_right","p1_up","p1_down")

func _physics_process(_delta):
	if isAttacking == false:
		velocity = direction * speed
		move_and_slide()
		if Input.is_action_pressed("sprint"):
			speed = 150
		else:
			speed = 100
