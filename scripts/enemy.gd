extends Node
class_name enemy

#higher the speed var slower the enemy
@export var speed = 100
var player_chase = false
var player = null
@onready var sprite = $AnimatedSprite2D

func body_entered(body:Node2D):
	if (body is Player):
		player = body
		player_chase = true

func body_exited(body:Node2D):
	if(body is Player):
		player = null
		player_chase = false
