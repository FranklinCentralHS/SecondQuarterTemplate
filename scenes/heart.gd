extends Area2D

func _on_body_entered(body:Node2D):
	if (body is Player):
		body.health += 10
		queue_free()
