extends Control

var xPosition = ProjectSettings.get_setting("display/window/size/width") / 2
var yPosition = ProjectSettings.get_setting("display/window/size/height") / 2

func _ready():
	$"Start".margin_left = xPosition - ($"Start".rect_size.x / 2)
	$"Start".margin_top = yPosition - ($"Start".rect_size.y / 2)

func _input(event):
	if (event is InputEventKey or event is InputEventJoypadButton or event is InputEventScreenTouch) and event.pressed:
		get_tree().change_scene("res://Scenes/Game.tscn")
