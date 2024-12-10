extends trap

@onready var rechargeTimer = $rechargeTimer
@onready var deployTimer = $deployTimer
@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	rechargeTimer.wait_time = rechargeTime

func _on_animated_sprite_2d_animation_finished() -> void:
	if state == "opening":
		state = "active"


func _on_detection_area_area_entered(area:Area2D) -> void:
	if area.name == "playerBody":
		if state == "active":
			#####put damage function in here when it is done#####
			sprite.play("closing")
			state = "inactive"
			rechargeTimer.start()


func _on_recharge_timer_timeout() -> void:
	sprite.play("opening")
	state = "opening"
