extends trap

@onready var rechargeTimer = $rechargeTimer
@onready var deployTimer = $deployTimer
@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	rechargeTimer.wait_time = rechargeTime


func _on_detection_area_area_entered(area:Area2D) -> void:
	if area.name == "playerBody":
		if state == "active":
			#####put damage function in here when it is done#####
			sprite.play("closing")
			state = "inactive"
