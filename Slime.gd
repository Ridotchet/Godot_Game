extends KinematicBody2D

var velocitat : Vector2
var acceleracio = 10
var enemic_dreta = false
var enemic_esquerra = false

func _ready():
	pass

func _process(delta):
	$AnimatedSprite.play('Idle')
	
	if not is_on_floor():
		velocitat.y += acceleracio
	else:
		velocitat.y = 0
	
	if enemic_esquerra == true:
		velocitat.x = -10
	else:
		velocitat.x = 0
	if enemic_dreta == true:
		velocitat.x = 10
	else:
		velocitat.x = 0
	
	
	velocitat = move_and_slide(velocitat)
	

func _on_Area2D_body_entered(body):
	if body.has_method('mal'):
		body.mal(10)
	

func _on_Area2D2_body_entered(body):
	if body.has_method('mal'):
		if body.position.x > position.x:
			enemic_dreta = true
		if body.position.x < position.x:
			enemic_esquerra = true
		
	

func _on_Area2D2_body_exited(body):
	if body.has_method('mal'):
		enemic_dreta = false
		enemic_esquerra = false
