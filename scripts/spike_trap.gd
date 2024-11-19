extends trap

@onready var rechargeTimer = $rechargeTimer
@onready var deployTimer = $deployTimer
@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	rechargeTimer.wait_time = rechargeTime
	deployTimer.wait_time = deployedTime
	rechargeTimer.start()


func _on_recharge_timer_timeout() -> void:
	sprite.play("deploying")
	state = "active"
	rechargeTimer.stop()
	deployTimer.start()


func _on_deploy_timer_timeout() -> void:
	sprite.play("retracting")
	state = "inactive"
	rechargeTimer.start()
	deployTimer.stop()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "playerBody":
		if state == "active":
			#put the damaging function in here
			pass
