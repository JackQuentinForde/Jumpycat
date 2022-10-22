extends StaticBody2D

onready var player = get_parent().get_node("Game/Player")
onready var game = get_parent().get_node("Game")

func _physics_process(_delta):
	if (!player.dead):
		if ((player.global_position.y < global_position.y - (game.maxYPosition - 100)) or (player.global_position.y > global_position.y + game.maxYPosition)) :
			queue_free()
	else:
		queue_free()
		
func Spring():
	$AnimationPlayer.play("Spring")
