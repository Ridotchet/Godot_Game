extends KinematicBody2D


var velocitat:Vector2
var acceleracio = 10


func _ready():
	$AnimatedSprite.scale = Vector2(0.2, 0.2)
	$CollisionShape2D.scale = Vector2(0.2, 0.2)

func _process(delta):
	velocitat.x = 0
	if Input.is_action_pressed("ui_right"):
		velocitat.x = 150
	if Input.is_action_pressed("ui_left"):
		velocitat.x = -150
	
	
	if not is_on_floor():
		velocitat.y += acceleracio
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor() or is_on_wall():
			velocitat.y = -400
	
	velocitat = move_and_slide(velocitat)
	
	anima(velocitat)
	

func anima(velocitat:Vector2):
	if velocitat.length() == 0:
		$AnimatedSprite.play('Quiet')
	elif Input.is_action_just_pressed("ui_up"):
		$AnimatedSprite.play('Salta')
	elif velocitat.x > 0:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play('Camina')
	elif velocitat.x < 0:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play('Camina')
