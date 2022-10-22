extends StaticBody2D

var breaking = false
onready var player = get_parent().get_node("Game/Player")
onready var game = get_parent().get_node("Game")

func _physics_process(delta):
	if (!player.dead):
		if ((player.global_position.y < global_position.y - (game.maxYPosition - 100)) or (player.global_position.y > global_position.y + game.maxYPosition)) :
			queue_free()
		if (breaking):
			get_node("Sprite").modulate.a -= delta
			if (get_node("Sprite").modulate.a <= 0):
				queue_free()
	else:
		queue_free()
		
func Break():
	get_node("Particles2D").emitting = true
	breaking = true
