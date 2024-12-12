extends CanvasLayer
class_name UI
@onready var rectangle: TextureProgressBar = $health_bar
@export var health : int

func _on_ready():
	rectangle.max_value = health
# Called every frame. 'delta' is the elapsed time since the previous frame.


func set_health(newHealth):
	rectangle.value = newHealth
