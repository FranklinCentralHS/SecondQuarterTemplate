extends enemy

func _process(delta: float) -> void:
	if attacking == false:
		if player_chase == true:
			self.position += (player.position - self.position)/speed

			sprite.play("moving")
			if (player.position.x - self.position.x) > 0:
				sprite.flip_h = false
			else:
				sprite.flip_h = true
		else:
			sprite.play("idle")

#changes state of enenmy to chase
func _on_detection_area_body_entered(body:Node2D) -> void:
	self.range_body_entered(body)
func _on_detection_area_body_exited(body:Node2D) -> void:
	self.range_body_exited(body)
