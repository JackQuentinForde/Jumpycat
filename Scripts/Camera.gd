extends Camera2D

var shakeAmount = 0
var default_offset = offset
onready var game = get_parent().get_parent()
onready var tween = $Tween
onready var timer = $Timer
var maxXPosition = ProjectSettings.get_setting("display/window/size/width") / 2

func _ready():
	limit_left = -maxXPosition
	limit_right = maxXPosition
	set_process(false)
	randomize()
	
func _process(_delta):
	offset = Vector2(rand_range(-1.0, 1.0) * shakeAmount, rand_range(-1.0, 1.0) * shakeAmount)
	
func Shake(time, amount):
	timer.wait_time = time
	shakeAmount = amount
	set_process(true)
	timer.start()

func _on_Timer_timeout():
	set_process(false)
	tween.interpolate_property(self, "offset", offset, default_offset, 0.1, 6, 2)
	tween.start()
