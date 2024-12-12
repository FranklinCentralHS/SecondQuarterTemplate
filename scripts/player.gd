extends CharacterBody2D
class_name Player

@onready var healthBar : UI = %HealthBar
@onready var timer : Timer = $DeathTimer
@onready var animations : AnimatedSprite2D = $AnimatedSprite2D
@onready var energyDisplay = %energyDisplay
@onready var energyRechargeTimer = $energyRechargeTimer

var speed: int = 100
var damage: int = 2
var energy = 100
var maxEnergy = 100
var rechargeEnergy = 10
var energyRechargeTime = 2.5


var health : int = 100 :
	set(value):
		health = value
		if healthBar != null:
			healthBar.set_health(value)
		if health <= 0:
			animations.play("death")
			is_dying = true
			if (timer.time_left == 0):
				timer.start()

enum Directions {UP, DOWN, LEFT, RIGHT}

var isAttacking = false
var direction: Vector2 = Vector2.ZERO
var facing : Directions = Directions.DOWN
var is_dying = false


var leftArea: Array = []
var rightArea: Array = []
var frontArea: Array = []
var backArea: Array = []

@onready var SwordSFX = $SwordSFX


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
	if Input.is_action_just_pressed("attack"):
		if energy - 10 >= 0:
			isAttacking = true
			if facing == Directions.LEFT && isAttacking == true:
				animations.play("attack_left")
				attack("left")
			elif facing == Directions.RIGHT && isAttacking == true:
				animations.play("attack_right")
				attack("right")
			elif facing == Directions.DOWN && isAttacking == true:
				animations.play("attack_down")
				attack("down")
			elif facing == Directions.UP && isAttacking == true:
				animations.play("attack_up")
				attack("up")

	if speed == 150:
		if energy - 1 < 0:
			speed = 100
		else:
			energy -= 20 * _delta
			energyDisplay.update(energy, maxEnergy)



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
#attacking functoin
func attack(attackDirection):
	energy -= 10
	energyDisplay.update(energy, maxEnergy)
	if attackDirection == "left":
		for enemyBody in leftArea:
			enemyBody.get_parent().damaged(damage)
	elif attackDirection == "right":
		for enemyBody in rightArea:
			enemyBody.get_parent().damaged(damage)
	elif attackDirection == "up":
		for enemyBody in backArea:
			enemyBody.get_parent().damaged(damage)
	elif attackDirection == "down":
		for enemyBody in frontArea:
			enemyBody.get_parent().damaged(damage)
	SwordSFX.play()


#detects enemiees going in and out of attack range
func _on_left_detection_body_exited(body:Node2D) -> void:
	if body.get_parent() is enemy:
		leftArea.erase(body)
func _on_left_detection_body_entered(body:Node2D) -> void:
	if body.get_parent() is enemy:
		leftArea.append(body)
func _on_right_detection_body_exited(body:Node2D) -> void:
	if body.get_parent() is enemy:
		rightArea.erase(body)
func _on_right_detection_body_entered(body:Node2D) -> void:
	if body.get_parent() is enemy:
		rightArea.append(body)
func _on_back_detection_body_exited(body:Node2D) -> void:
	if body.get_parent() is enemy:
		backArea.erase(body)
func _on_back_detection_body_entered(body:Node2D) -> void:
	if body.get_parent() is enemy:
		backArea.append(body)
func _on_front_detection_body_exited(body:Node2D) -> void:
	if body.get_parent() is enemy:
		frontArea.erase(body)
func _on_front_detection_body_entered(body:Node2D) -> void:
	if body.get_parent() is enemy:
		frontArea.append(body)


func _on_energy_recharge_timer_timeout() -> void:
	if energy + rechargeEnergy < maxEnergy:
		energy += rechargeEnergy
	elif energy + rechargeEnergy >= maxEnergy:
		energy = maxEnergy
	energyDisplay.update(energy, maxEnergy)
