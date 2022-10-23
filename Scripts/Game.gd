extends Node2D

var maxXPosition = ProjectSettings.get_setting("display/window/size/width") / 2
var maxYPosition = ProjectSettings.get_setting("display/window/size/height")
var rng = RandomNumberGenerator.new()
var basicPlatform = load("res://Scenes/Basic Platform.tscn")
var platform = load("res://Scenes/Normal Platform.tscn")
var breakingPlatform = load("res://Scenes/Breaking Platform.tscn")
var movingPlatform = load("res://Scenes/Moving Platform.tscn")
var spikedPlatform = load("res://Scenes/Spiked Platform.tscn")
var invisiblePlatform = load("res://Scenes/Invisible Platform.tscn")
var jumpingPlatform = load("res://Scenes/Jumping Platform.tscn")
var spikedBall = load("res://Scenes/Spike Ball.tscn")
var lastPlayerYPosition
var lastPlatformYPosition
var lastPlatformType = ""
var platformMoveDirection = 1
onready var player = get_node("Player")
onready var globalScript = get_node("/root/Global")

func _ready():
	$Control/CanvasLayer/Highscore.text = "HI: " + globalScript.ReadHighScore()
	lastPlatformYPosition = 0
	for n in 10:
		AddBasicPlatform()
	rng.randomize()
	platformMoveDirection = rng.randi_range(1, 2)
	globalScript.score = 0
	
func _physics_process(_delta):
	if (-player.global_position.y > globalScript.score):
		globalScript.score = int(-player.global_position.y)
	$Control/CanvasLayer/Score.text = str(globalScript.score)
	if (player.global_position.y < lastPlatformYPosition + 150):
		AddPlatform()
	if (player.global_position.y > lastPlatformYPosition + 1000):
		GameOver()
		
func AddPlatform():
	rng.randomize()
	var n = rng.randi_range(1, 21)
	if (n  <= 4):
		lastPlatformType = "Normal"
		AddNormalPlatform()
	elif (n <= 8):
		lastPlatformType = "Breaking"
		AddBreakingPlatform()
	elif (n <= 12):
		lastPlatformType = "Moving"
		AddMovingPlatform()
	elif (n <= 16):
		lastPlatformType = "Invisible"
		AddInvisiblePlatform()
	elif (n <= 19):
		lastPlatformType = "Jumping"
		AddJumpPlatform()
	elif(lastPlatformType != "Spikes"):
		lastPlatformType = "Spikes"
		rng.randomize()
		var x = rng.randi_range(1, 4)
		if (x <= 2):
			AddSpikedBall()
		else:
			AddSpikedPlatform()
	else:
		lastPlatformType = "Normal"
		AddNormalPlatform()
	
func AddBasicPlatform():
	rng.randomize()
	var x = rng.randi_range(-(maxXPosition - 11), maxXPosition - 11)
	var newPlatform = basicPlatform.instance()
	newPlatform.global_position = Vector2(x, lastPlatformYPosition - 50)
	lastPlatformYPosition = newPlatform.position.y
	get_parent().call_deferred("add_child", newPlatform)
		
func AddNormalPlatform():
	rng.randomize()
	var x = rng.randi_range(-(maxXPosition - 11), maxXPosition - 11)
	var newPlatform = platform.instance()
	newPlatform.global_position = Vector2(x, lastPlatformYPosition - 50)
	lastPlatformYPosition = newPlatform.position.y
	get_parent().call_deferred("add_child", newPlatform)

func AddBreakingPlatform():
	rng.randomize()
	var x = rng.randi_range(-(maxXPosition - 11), maxXPosition - 11)
	var newPlatform = breakingPlatform.instance()
	newPlatform.global_position = Vector2(x, lastPlatformYPosition - 50)
	lastPlatformYPosition = newPlatform.position.y
	get_parent().call_deferred("add_child", newPlatform)
	
func AddMovingPlatform():
	rng.randomize()
	var x = rng.randi_range(-(maxXPosition - 11), maxXPosition - 11)
	var newPlatform = movingPlatform.instance()
	newPlatform.global_position = Vector2(x, lastPlatformYPosition - 50)
	lastPlatformYPosition = newPlatform.position.y
	get_parent().call_deferred("add_child", newPlatform)
	match platformMoveDirection:
		1:
			platformMoveDirection = 2
		2:
			platformMoveDirection = 1
			
func AddSpikedPlatform():
	rng.randomize()
	var x = rng.randi_range(-(maxXPosition - 11), maxXPosition - 11)
	var newPlatform = spikedPlatform.instance()
	newPlatform.global_position = Vector2(x, lastPlatformYPosition - 50)
	lastPlatformYPosition = newPlatform.position.y
	get_parent().call_deferred("add_child", newPlatform)
	
func AddSpikedBall():
	rng.randomize()
	var x = rng.randi_range(-(maxXPosition - 11), maxXPosition - 11)
	var newPlatform = spikedBall.instance()
	newPlatform.global_position = Vector2(x, lastPlatformYPosition - 50)
	lastPlatformYPosition = newPlatform.position.y
	get_parent().call_deferred("add_child", newPlatform)
	
func AddInvisiblePlatform():
	rng.randomize()
	var x = rng.randi_range(-(maxXPosition - 11), maxXPosition - 11)
	var newPlatform = invisiblePlatform.instance()
	newPlatform.global_position = Vector2(x, lastPlatformYPosition - 50)
	lastPlatformYPosition = newPlatform.position.y
	get_parent().call_deferred("add_child", newPlatform)
	
func AddJumpPlatform():
	rng.randomize()
	var x = rng.randi_range(-(maxXPosition - 11), maxXPosition - 11)
	var newPlatform = jumpingPlatform.instance()
	newPlatform.global_position = Vector2(x, lastPlatformYPosition - 50)
	lastPlatformYPosition = newPlatform.position.y
	get_parent().call_deferred("add_child", newPlatform)
			
func GameOver():
	globalScript.SaveScore()
	get_tree().change_scene("res://Scenes/Game Over.tscn")
	
