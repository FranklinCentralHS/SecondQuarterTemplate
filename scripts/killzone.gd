extends Area2D


@onready var timer = $Timer
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body:Node2D):
    print("You died!")
    Engine.time_scale = 0.5
    body.get_node("CollisionShape2D").queue_free()
    timer.start()
    animation_player.play("DeathSoundFX")


func _on_timer_timeout():
    Engine.time_scale = 1.0
    get_tree().reload_current_scene()





