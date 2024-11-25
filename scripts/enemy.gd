extends Node
class_name enemy

#higher the speed var slower the enemy
@export var speed = 100
#higher the speed slower the attack
@export var attack_speed = 1
@export var damage = 1

#change of state vars
var player_chase = false
var player = null
var attacking = false

@onready var sprite = $AnimatedSprite2D
@onready var attackTimer = $attackTimer


func _ready() -> void:
	attackTimer.wait_time = attack_speed

#chases player if in range
func range_body_entered(body:Node2D):
	if (body is Player):
		player = body
		player_chase = true
#stops chasing player if out of range
func range_body_exited(body:Node2D):
	if(body is Player):
		player = null
		player_chase = false

#starts attack cooldown
func start_attack_timer():
	attackTimer.start()
	attacking = true

#stops attack cooldown
func stop_attack_timer():
	attackTimer.stop()
	attacking = false

func attack():
	sprite.play("attack")
