extends StaticBody2D

onready var player = get_parent().get_node("Game/Player")
onready var game = get_parent().get_node("Game")

func _physics_process(_delta):
	if (!player.dead):
		if ((player.global_position.y < global_position.y - game.maxYPosition) or (player.global_position.y > global_position.y + (game.maxYPosition + 200))):
			queue_free()
	else:
		queue_free()
