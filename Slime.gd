extends KinematicBody2D

var velocitat : Vector2
var acceleracio = 10
var enemic_dreta = false
var enemic_esquerra = false
var target :KinematicBody2D
var target_no :KinematicBody2D
var moviment_no = 1
var moviment = 1

func _ready():
	$TimerSalt.wait_time = 3
	$TimerSalt.start()
	
#	collision_layer = 8
#	collision_mask = 2147483651

func _process(delta):
	$AnimatedSprite.play('Idle')
	
	if not is_on_floor():
		velocitat.y += acceleracio
	
	if target:
		if target.position.x > position.x and velocitat.x < 50:
			if moviment == -1:
				moviment *= -1
			if is_on_floor():
				velocitat.y -= 150
				velocitat.x += 100
		elif target.position.x < position.x and velocitat.x > -50:
			if moviment == 1:
				moviment *= -1
			if is_on_floor():
				velocitat.y -= 150
				velocitat.x -= 100
			
	if is_on_floor():
		if velocitat.x > 0:
			velocitat.x -= acceleracio
		elif velocitat.x < 0:
			velocitat.x += acceleracio
	
	
	velocitat = move_and_slide(velocitat, Vector2.UP)
	
	
	if position.y > 2000:
		queue_free()
	

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
		if not target:
			velocitat.y -= 150
			velocitat.x += 150*moviment_no
			moviment_no *= -1
	$TimerSalt.start()
	
func mort_slime():
	collision_layer = 8
	collision_mask = 2147483648

	velocitat.x = 300
	velocitat.y = -200
