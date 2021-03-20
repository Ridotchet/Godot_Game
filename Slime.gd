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
	
	velocitat = move_and_slide(velocitat)
	
	if enemic_esquerra == true:
		position.x -= 10*delta
	if enemic_dreta == true:
		position.x += 10*delta
	


func _on_Area2D_body_entered(body):
	if body.has_method('mal'):
		body.mal(10)
		body.velocitat.y -= 100


func _on_Area2D2_body_entered(body):
	if body.has_method('mal'):
		if body.position.x > position.x:
			enemic_dreta = true
		else:
			enemic_dreta = false
		
		if body.position.x < position.x:
			enemic_esquerra = true
		else:
			enemic_esquerra = false
		
