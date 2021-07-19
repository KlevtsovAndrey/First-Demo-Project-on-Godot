extends KinematicBody2D

const UP = Vector2(0, -1)
export (float) var GRAVITY = 20
export (float) var MAXFALLSPEED = 200
export (float) var MAXSPEED = 80
export (float) var JUMPFORCE = 300
export (float) var ACCEL = 10
export (bool) var facing_right = true
var motion = Vector2()
	
func _physics_process(delta):
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
		
	# Flipping sprite toward the way we're heading
	if facing_right == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
	
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	# Walking left or right
	if Input.is_action_pressed("right"):
		motion.x += ACCEL
		facing_right = true
	elif Input.is_action_pressed("left"):
		motion.x -= ACCEL
		facing_right = false
	else:
		motion.x = lerp(motion.x, 0, 0.5)
	# Jumping
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMPFORCE
		
	motion = move_and_slide(motion, UP)
