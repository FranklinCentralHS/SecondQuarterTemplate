extends Node2D

#higher the speed var slower the enemy
@export var speed = 100
var player_chase = false
var player = null
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta: float):
	if player_chase == true:
		position += (player.position - position)/speed

		sprite.play("moving")
		if(player.position.x - position.x) < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	else:
		sprite.play("idle")

func _on_detection_area_body_entered(body:Node2D) -> void:
	player = body
	player_chase = true


func _on_detection_area_body_exited(body:Node2D) -> void:
	player = null
	player_chase = false
