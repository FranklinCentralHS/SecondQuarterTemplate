extends Area2D
@onready var animation_player = $AnimationPlayer
func _on_body_entered(body:Node2D):
	if (body is Player):
		body.health += 10
		animation_player.play("pickup")
