extends KinematicBody2D
signal hit
export var speed = 400
var screen_size
const gra = 800
var speedy = 0
func _ready():
	print("hello")
	screen_size = get_viewport_rect().size
	
func  _physics_process(delta):
	speedy += delta * gra
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		$AnimatedSprite.flip_h = true
		velocity.x += 1
		$Particles2D.position = Vector2(-9, 40)
	if Input.is_action_pressed("move_left"):
		$AnimatedSprite.flip_h = false
		velocity.x -= 1
		$Particles2D.position = Vector2(9, 40)
	# if Input.is_action_pressed("move_down"):
	# 	velocity.y += 1
	# 	$AnimatedSprite.play("walk")
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		speedy = 0
	# print(velocity)
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if $AnimatedSprite.animation == "stop":
			$AnimatedSprite.play("walk")
		$Particles2D.emitting = true
	else:
		if $AnimatedSprite.animation == "walk":
			$AnimatedSprite.play("stop")
		$Particles2D.emitting = false
		
#		$AnimatedSprite.play()
#	else:
#		$AnimatedSprite.stop()
	velocity += Vector2(0, speedy)


	velocity = move_and_slide(velocity)
	# for i in get_slide_count():
	# 	var collision = get_slide_collision(i)
	# 	print("I collided with ", collision.collider.name)
	
	# position += velocity * delta
	# position.x = clamp(position.x, 0, screen_size.x)
	# position.y = clamp(position.y, 0, screen_size.y)

#	if velocity.x != 0:
#		$AnimatedSprite.animation = "walk"
#		$AnimatedSprite.flip_v = false
#		# See the note below about boolean assignment.
#		$AnimatedSprite.flip_h = velocity.x < 0
#	elif velocity.y != 0:
#		$AnimatedSprite.animation = "up"
#		$AnimatedSprite.flip_v = velocity.y > 0
#
#	if velocity.x < 0:
#		$AnimatedSprite.flip_h = true
#	else:
#		$AnimatedSprite.flip_h = false
		
func start(pos):
	speedy = 0
	position = pos
	show()
	$CollisionShape2D.disabled = false
	$AnimatedSprite.play("stop")


func _on_Player_body_entered(_body):
	print("fuck")
	hide() # Player disappears after being hit.
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	# $CollisionShape2D.set_deferred("disabled", true) # Replace with function body.




func _on_Area2D_body_entered(body:Node):
	if body.name != "Player": 
		print("fuck")
		hide() # Player disappears after being hit.
		emit_signal("hit")
		# Must be deferred as we can't change physics properties on a physics callback.
		# $CollisionShape2D.set_deferred("disabled", true)



