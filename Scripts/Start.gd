extends Control

var xPosition = ProjectSettings.get_setting("display/window/size/width") / 2
var yPosition = ProjectSettings.get_setting("display/window/size/height") / 2
onready var globalScript = get_node("/root/Global")

func _ready():
	$CanvasLayer/Highscore.text = "HI: " + globalScript.ReadHighScore()

func _input(event):
	if (event is InputEventKey or event is InputEventJoypadButton or event is InputEventScreenTouch) and event.pressed:
		get_tree().change_scene("res://Scenes/Game.tscn")
