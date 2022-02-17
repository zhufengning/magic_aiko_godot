extends KinematicBody2D
signal hit
export var speed = 400
var screen_size
const gra = 800
var speedy = 0
func _ready():
	print("hello")
	print(Vector2(-1, 0).angle())
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
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		speedy = 0
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if $AnimatedSprite.animation == "stop":
			$AnimatedSprite.play("walk")
		$Particles2D.emitting = true
	else:
		if $AnimatedSprite.animation == "walk":
			$AnimatedSprite.play("stop")
		$Particles2D.emitting = false

		
	velocity += Vector2(0, speedy)
	move_and_slide(velocity)
		
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



