extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
@export var speed: int = 50
@onready var animations = $AnimatedSprite2D

func _process(_delta):
	direction = Input.get_vector("left", "right", "up", "down")
	if direction = "down":
		animations.play("move_down")
func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()

func _ready():
	animations.play("move_down")
