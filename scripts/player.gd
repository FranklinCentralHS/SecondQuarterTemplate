extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
@export var speed: int = 100
@onready var animations = $AnimatedSprite2D

func _process(_delta):
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x < 0:
		animations.play("move_left")
	elif direction.x > 0:
		animations.play("move_right")
	elif direction.y > 0:
		animations.play("move_down")
	elif direction.y < 0:
		animations.play("move_up")
	elif direction.x == 0:
		animations.play("idle_forward")

func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()
	if Input.is_action_pressed("sprint"):
		speed = 150
	else:
		speed = 100
