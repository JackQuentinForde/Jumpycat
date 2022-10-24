extends KinematicBody2D

const GRAVITY = 600
const INITIAL_VELOCITY = 450
const JUMP_VELOCITY = 550
const ACCEL = 700
const MAX_SPEED = 350
const FALL_SPEED = 500

var rng = RandomNumberGenerator.new()
var velocity = Vector2()
var direction = null
var dying = false
var dead = false
var deathSoundPlayed = false
var opacity = 1
var jumpSprite = load("res://Assets/Sprites/jumpycat.png")
var fallSprite = load("res://Assets/Sprites/fallycat.png")
var maxXPosition = ProjectSettings.get_setting("display/window/size/width") / 2
onready var sprite = get_node("Sprite")
onready var game = get_parent()

func _ready():
	rng.randomize()
	var colour1 = rng.randf_range(0, 1)
	var colour2 = rng.randf_range(0, 1)
	var colour3 = rng.randf_range(0, 1)
	sprite.set_self_modulate(Color(colour1, colour2, colour3, 1))
	dying = false
	dead = false
	deathSoundPlayed = false
	opacity = 1
	velocity.y = -INITIAL_VELOCITY
				
func Move(delta):
		velocity.x = Input.get_accelerometer().normalized().x * ACCEL
		
		if (velocity.x > 49):
			get_node("Sprite").flip_h = false
		elif (velocity.x < -49):
			get_node("Sprite").flip_h = true
		
		if (velocity.x > MAX_SPEED):
				velocity.x = MAX_SPEED
		elif (velocity.x < -MAX_SPEED):
			velocity.x = -MAX_SPEED
		
func ApplyGravity(var delta):
	if (velocity.y < FALL_SPEED):
		velocity.y += GRAVITY * delta
		if (velocity.y > FALL_SPEED):
			velocity.y = FALL_SPEED
		
func SetSprite():
	if (velocity.y > 0):
		if (sprite.texture != fallSprite):
			sprite.set_texture(fallSprite)
	else:
		if (sprite.texture != jumpSprite):
			sprite.set_texture(jumpSprite)
			
func CheckPosition():
	if (global_position.x > maxXPosition):
		global_position.x = -maxXPosition
	if (global_position.x < -maxXPosition):
		global_position.x = maxXPosition

func CheckCollisions(collisionInfo):
	if (collisionInfo):
		if ("Normal Platform" in collisionInfo.collider.name or "Moving Platform" in collisionInfo.collider.name):
			if (collisionInfo.collider.boostChance == 1):
				collisionInfo.collider.get_node("Sprite2").visible = false
				velocity.y = -JUMP_VELOCITY * 3
				$BoostSound.play()
			else:
				velocity.y = -JUMP_VELOCITY
				$JumpSound.play()
		elif ("Breaking Platform" in collisionInfo.collider.name):
			velocity.y = -JUMP_VELOCITY
			$JumpSound.play()
			collisionInfo.collider.Break()
			$Camera2D.Shake(0.1, 1)
		elif ("Spiked Platform" in collisionInfo.collider.name):
			dying = true
		elif ("Spike Ball" in collisionInfo.collider.name):
			if (collisionInfo.collider.get_node("Sprite2").visible):
				dying = true
			else:
				velocity.y = -JUMP_VELOCITY
				$JumpSound.play()
		elif ("Jumping Platform" in collisionInfo.collider.name):
			velocity.y = -JUMP_VELOCITY * 2
			$SpringSound.play()
			collisionInfo.collider.Spring()
		else:
			velocity.y = -JUMP_VELOCITY
			$JumpSound.play()

func Die(delta):
	if (!deathSoundPlayed):
		deathSoundPlayed = true
		$DeathSound.play()
	opacity -= delta * 3
	modulate.a = opacity
	if (opacity <= -3):
		dead = true
		game.GameOver()

func _physics_process(delta):
	if (!dying):
		Move(delta)
		ApplyGravity(delta)
		SetSprite()
		var collisionInfo = move_and_collide(velocity * delta)
		CheckCollisions(collisionInfo)
		CheckPosition()
	else:
		Die(delta)
