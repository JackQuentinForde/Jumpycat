extends KinematicBody2D

onready var player = get_parent().get_node("Game/Player")
onready var game = get_parent().get_node("Game")
var direction = 1
var speed = 25
var velocity = Vector2(0,0)
var yPosition = 0

func _ready():
	$AnimationPlayer.play("spike")
	yPosition = global_position.y
	direction = get_parent().get_node("Game").platformMoveDirection

func move():
	match(direction):
		1:
			if (global_position.x >= game.maxXPosition):
				$Sprite.flip_h = true
				direction = 2
		2:
			if (global_position.x <= -game.maxXPosition):
				$Sprite.flip_h = false
				direction = 1

func _physics_process(delta):
	move()
	if (!player.dead):
		if ((player.global_position.y < global_position.y - (game.maxYPosition - 100)) or (player.global_position.y > global_position.y + game.maxYPosition)) :
			queue_free()
	else:
		queue_free()
	if (direction == 1):
		velocity = Vector2(speed, 0)
	else:
		velocity = Vector2(-speed, 0)
	move_and_collide(velocity * delta)
	global_position.y = yPosition
