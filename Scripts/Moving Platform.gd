extends KinematicBody2D

onready var player = get_parent().get_node("Game/Player")
onready var game = get_parent().get_node("Game")
var direction = 1
var speed = 25
var velocity = Vector2(0,0)
var yPosition = 0
var boostChance
var rng = RandomNumberGenerator.new()

func _ready():
	$AnimationPlayer.play("spin")
	rng.randomize()
	boostChance = rng.randi_range(1, 8)
	if (boostChance == 1):
		$Sprite2.visible = true
	else:
		$Sprite2.visible = false
	yPosition = global_position.y
	direction = get_parent().get_node("Game").platformMoveDirection

func move():
	match(direction):
		1:
			if (global_position.x >= (game.maxXPosition - 10)):
				direction = 2
		2:
			if (global_position.x <= -(game.maxXPosition - 10)):
				direction = 1

func _physics_process(delta):
	move()
	if (!player.dead):
		if ((player.global_position.y < global_position.y - game.maxYPosition) or (player.global_position.y > global_position.y + (game.maxYPosition + 200))):
			queue_free()
	else:
		queue_free()
	if (direction == 1):
		velocity = Vector2(speed, 0)
	else:
		velocity = Vector2(-speed, 0)
	move_and_collide(velocity * delta)
	global_position.y = yPosition
