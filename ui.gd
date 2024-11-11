extends CanvasLayer
@onready var rectangle: TextureProgressBar = $health_bar
@onready var h_scroll_bar: HScrollBar = $scroll/HScrollBar
@onready var progress_bar: ProgressBar = $scroll/ProgressBar




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_bar.value = h_scroll_bar.value
	rectangle.value = progress_bar.value
