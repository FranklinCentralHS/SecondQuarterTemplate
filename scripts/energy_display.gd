extends Panel

@onready var label : Label = $Label

func update(energy: int, maxEnergy: int):
	label.text = str(energy) + "/" + str(maxEnergy)
