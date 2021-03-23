extends KinematicBody2D

var velocitat:Vector2
var acceleracio = 10
export var vida = 100
var temps = 5
var inmunitat :bool

func _ready():
	$AnimatedSprite.scale = Vector2(0.2, 0.2)
	
	$CollisionShape2D.scale = Vector2(0.2, 0.2)
	
	$Inmunitat.wait_time = 4
	
	$Visibilitat.wait_time = 0.5
	


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
	
	velocitat = move_and_slide(velocitat, Vector2.UP)
	
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
	


func mal(quantitat):
	if inmunitat == false:
		vida -= quantitat
		print(vida)
		$Inmunitat.start()
		inmunitat = true
		collision_mask = 2147483650
		$Visibilitat.start()
		visible = false
		if vida == 0:
			queue_free()


func _on_Visibilitat_timeout():
	if inmunitat == true:
		if visible == false:
			visible = true
		else:
			visible = false
		$Visibilitat.start()
	elif visible == false:
		visible = true


func _on_Inmunitat_timeout():
	inmunitat = false
	collision_mask = 2147483658
