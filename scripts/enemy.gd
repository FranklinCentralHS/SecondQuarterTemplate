extends Node2D
class_name enemy

#higher the speed var slower the enemy
@export var speed = 100
#higher the speed slower the attack
@export var attack_speed = 1
@export var damage = 1
@export var health = 5

#change of state vars
var player_chase = false
var player = null
var attacking = false
#alive or dying
var state = "alive"

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

func damaged(damageTaken):
	health -= damageTaken
	sprite.modulate = Color(1,0,0)
	await get_tree().create_timer(0.2).timeout #wait for 2 seconds
	sprite.modulate = Color(1,1,1)
	if health<=0 and state!="dying":
		await get_tree().create_timer(0.2).timeout
		queue_free()
#checks if player is in range of melee attack
func _on_attack_area_body_entered(body:Node2D) -> void:
	if(body is Player):
		self.start_attack_timer()
		body.health -= damage
func _on_attack_area_body_exited(body:Node2D) -> void:
	if(body is Player):
		self.stop_attack_timer()
