extends StaticBody2D

onready var player = get_parent().get_node("Game/Player")
onready var game = get_parent().get_node("Game")
var boostChance
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	boostChance = rng.randi_range(1, 8)
	if (boostChance == 1):
		$Sprite2.visible = true
	else:
		$Sprite2.visible = false

func _physics_process(_delta):
	if (!player.dead):
		if ((player.global_position.y < global_position.y - (game.maxYPosition - 100)) or (player.global_position.y > global_position.y + game.maxYPosition)) :
			queue_free()
	else:
		queue_free()
