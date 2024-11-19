extends CharacterBody2D

var isAttacking = false
var direction: Vector2 = Vector2.ZERO
@export var speed: int = 100
@onready var animations : AnimatedSprite2D = $AnimatedSprite2D

func _process(_delta):
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x < 0 && isAttacking == false:
		animations.play("move_left")
	elif direction.x > 0 && isAttacking == false:
		animations.play("move_right")
	elif direction.y > 0 && isAttacking == false:
		animations.play("move_down")
	elif direction.y < 0 && isAttacking == false:
		animations.play("move_up")
	elif direction.x == 0 && isAttacking == false:
		animations.play("idle_forward")
	if Input.is_action_pressed("attack"):
			animations.play("attack_front")
			isAttacking = true


func _physics_process(_delta):
	if isAttacking == false:
		velocity = direction * speed
		move_and_slide()
		if Input.is_action_pressed("sprint"):
			speed = 150
		else:
			speed = 100


func _on_animated_sprite_2d_animation_finished():
	if animations.animation == "attack_front":
		isAttacking = false
