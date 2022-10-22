extends StaticBody2D

onready var player = get_parent().get_node("Game/Player")
onready var game = get_parent().get_node("Game")
onready var timer = $Timer
var waitTime = 0.5
var direction = 1

func _ready():
	direction = 1

func Modulate(delta):
	match direction:
		1:
			get_node("Sprite").modulate.a -= delta
			if (get_node("Sprite").modulate.a <= 0):
				timer.wait_time = waitTime
				timer.start()
				direction = 0
		2:
			get_node("Sprite").modulate.a += delta
			if (get_node("Sprite").modulate.a >= 1):
				direction = 1
	
func _physics_process(delta):
	if (!player.dead):
		if ((player.global_position.y < global_position.y - (game.maxYPosition - 100)) or (player.global_position.y > global_position.y + game.maxYPosition)) :
			queue_free()
		Modulate(delta * 3)
	else:
		queue_free()

func _on_Timer_timeout():
	direction = 2
