extends Control

var dialogue =[]
var current_dialogue_id = 0
var d_active = false



func _ready():
	$Label.visible = false
	
func _start():
	if d_active:
		return
	d_active = true
