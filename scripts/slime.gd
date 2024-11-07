extends Node2D

var speed = 25
var player_chase = false
var player = null

func _physics_process(delta: float):
	if player_chase == true:
		position += (player.position - position)

func _on_detection_area_body_entered(body:Node2D) -> void:
	player = body
	player_chase = true


func _on_detection_area_body_exited(body:Node2D) -> void:
	player = null
	player_chase = false
