extends KinematicBody2D

var motion = Vector2()
const UP = Vector2(0,-1)
const MAXSPEED = 80

var movingRight = true

onready var bg = get_node("../../")

func _ready():
	pass
	
func _process(delta):
	if position.x > 110:
		bg.scroll_offset.x = -(position.x - 110)

func _physics_process(delta):
	motion.y += 14
	
	if is_on_floor():
		motion.x = 0
		if Input.is_action_pressed("ui_right") or Input.is_mouse_button_pressed(1):
			motion.x += MAXSPEED
		elif position.x > 4 and Input.is_action_pressed("ui_left"):
			motion.x -= MAXSPEED
		
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -300
	else:
		if motion.x > -MAXSPEED and Input.is_action_pressed("ui_left"):
			motion.x -= 2
		elif motion.x < MAXSPEED and Input.is_action_pressed("ui_right"):
			motion.x += 2
	
	if motion.x > 0:
		movingRight = true
		$AnimatedSprite.flip_h = false
	elif motion.x < 0:
		movingRight = false
		$AnimatedSprite.flip_h = true
		
	if motion.x != 0 and is_on_floor():
		$AnimatedSprite.animation = "run_right"
		$AnimatedSprite.play()
	else:
		if motion.x != 0:
			if motion.y > -100 and motion.y < 100:
				$AnimatedSprite.animation = "jump2"
			else:
				$AnimatedSprite.animation = "jump1"
		else:
			if is_on_floor():
				$AnimatedSprite.animation = "stand_right"
			else:
				if motion.y > -100 and motion.y < 100:
					$AnimatedSprite.animation = "jump2"
				else:
					$AnimatedSprite.animation = "jump1"
		$AnimatedSprite.stop()
		
	motion = move_and_slide(motion, UP)