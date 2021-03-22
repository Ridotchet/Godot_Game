extends KinematicBody2D

var velocitat : Vector2
var acceleracio = 10
var enemic_dreta = false
var enemic_esquerra = false
var target :KinematicBody2D
var target_no :KinematicBody2D

func _ready():
	$Timer.wait_time = 3
	$Timer.start()

func _process(delta):
	$AnimatedSprite.play('Idle')
	
	if not is_on_floor():
		velocitat.y += acceleracio
	
	if enemic_esquerra == true:
		velocitat.x = -10
	else:
		velocitat.x = 0
	if enemic_dreta == true:
		velocitat.x = 10
	else:
		velocitat.x = 0
	
	if target:
		if target.position.x > position.x:
			velocitat.x += 100
		elif target.position.x < position.x:
			velocitat.x -= 100
		
	
	velocitat = move_and_slide(velocitat)
	

func _on_Area2D_body_entered(body):
	if body.has_method('mal'):
		body.mal(10)
	

func _on_Area2D2_body_entered(body):
	if body.has_method('mal'):
		target = body
		
	

func _on_Area2D2_body_exited(body):
	if body.has_method('mal'):
		target = target_no

func _on_Timer_timeout():
	if is_on_floor():
		velocitat.y -= 200
	$Timer.start()
