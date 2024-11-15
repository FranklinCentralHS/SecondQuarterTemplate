extends CharacterBody2D


const SPEED = 100

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
		

	# Handle jump.
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	var updown := Input.get_axis("ui_up","ui_down")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if updown:
		velocity.y = updown * SPEED
	else:
		velocity.y = move_toward(velocity.y,0,SPEED)

	set_direction()

	move_and_slide()

	



func set_direction():
	if Input.is_action_pressed("ui_left"):
		sprite.play("left")
		
	elif Input.is_action_pressed("ui_right"):
		sprite.play("right")

	elif Input.is_action_pressed("ui_up"):
		sprite.play("up")
		
	elif Input.is_action_pressed("ui_down"):
		sprite.play("down")
	
	else:
		sprite.play("idle")  # Play "idle" animation when no buttons are pressed
