extends CharacterBody2D
class_name Player

@onready var healthBar : UI = %HealthBar
@onready var timer : Timer = $DeathTimer

var is_dying = false


enum Directions {UP, DOWN, LEFT, RIGHT}

var isAttacking = false
var direction: Vector2 = Vector2.ZERO
@export var speed: int = 100
@onready var animations : AnimatedSprite2D = $AnimatedSprite2D
var facing : Directions = Directions.DOWN
var health : int = 100 :
	set(value):
		print(value)
		health = value
		if healthBar != null:
			healthBar.set_health(value)
		if health <= 0:
			animations.play("death")
			is_dying = true
			if (timer.time_left == 0):
				timer.start()





func _process(_delta):
	direction = Input.get_vector("left", "right", "up", "down")
	#MOVEMENT
	if direction.x < 0 && isAttacking == false && not is_dying:
		animations.play("move_left")
		facing = Directions.LEFT
	elif direction.x > 0 && isAttacking == false && not is_dying:
		animations.play("move_right")
		facing = Directions.RIGHT
	elif direction.y > 0 && isAttacking == false && not is_dying:
		animations.play("move_down")
		facing = Directions.DOWN
	elif direction.y < 0 && isAttacking == false && not is_dying:
		animations.play("move_up")
		facing = Directions.UP
	 # Handle idle animations based on direction
	elif direction.x == 0 && direction.y == 0 && isAttacking == false && not is_dying:
		# Player is idle, check facing direction and choose appropriate idle animation
		if facing == Directions.LEFT && isAttacking == false && not is_dying:
			animations.play("idle_left")
		elif facing == Directions.RIGHT && isAttacking == false && not is_dying:
			animations.play("idle_right")
		elif facing == Directions.DOWN && isAttacking == false && not is_dying:
			animations.play("idle_down")
		elif facing == Directions.UP && isAttacking == false && not is_dying:
			animations.play("idle_up")
	#Attack Update
	if Input.is_action_pressed("attack"):
			isAttacking = true
			if facing == Directions.LEFT && isAttacking == true:
				animations.play("attack_left")
			elif facing == Directions.RIGHT && isAttacking == true:
				animations.play("attack_right")
			elif facing == Directions.DOWN && isAttacking == true:
				animations.play("attack_down")
			elif facing == Directions.UP && isAttacking == true:
				animations.play("attack_up")


func _physics_process(_delta):
	if isAttacking == false:
		velocity = direction * speed
		move_and_slide()
		if Input.is_action_pressed("sprint"):
			speed = 150
		else:
			speed = 100


func _on_animated_sprite_2d_animation_finished():
	if animations.animation == "attack_down" or "attack_up" or "attack_left" or "attack_right":
		isAttacking = false


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
