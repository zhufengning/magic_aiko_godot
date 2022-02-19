extends KinematicBody2D
signal hit
export var speed = 400
var screen_size
const gra = 800
var speedy = 0
var great = false

func _ready():
	screen_size = get_viewport_rect().size
	
func  _physics_process(delta):
	speedy += delta * gra

	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		$AnimatedSprite.flip_h = true
		$AnimatedSprite/hairl.position.x = -$AnimatedSprite/hairl.position.x
		$AnimatedSprite/hairr.position.x = -$AnimatedSprite/hairr.position.x
		$AnimatedSprite/hairl.process_material.direction.x = -$AnimatedSprite/hairl.process_material.direction.x
		$AnimatedSprite/hairr.process_material.direction.x = -$AnimatedSprite/hairr.process_material.direction.x
		velocity.x += 1
		$Particles2D.position = Vector2(-9, 40)
	if Input.is_action_pressed("move_left"):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite/hairl.position.x = -$AnimatedSprite/hairl.position.x
		$AnimatedSprite/hairr.position.x = -$AnimatedSprite/hairr.position.x
		$AnimatedSprite/hairl.process_material.direction.x = -$AnimatedSprite/hairl.process_material.direction.x
		$AnimatedSprite/hairr.process_material.direction.x = -$AnimatedSprite/hairr.process_material.direction.x
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
	$Health.value = 200
	speedy = 0
	position = pos
	show()
	$AnimatedSprite.play("stop")

func _on_Area2D_body_entered(body:Node):
	if great:
		return
	if "mobs" in body.get_groups(): 
		body.godie()
		$Health.value -= 5
		if $Health.value <= 0:
			hide() # Player disappears after being hit.
			emit_signal("hit")
		else:
			print("player great")
			great = true
			$Protect.visible = true
			$CollisionShape2D2.shape.radius = 45
			$GreatTimer.start()


func _on_GreatTimer_timeout():
	great = false
	$Protect.visible = false
	$CollisionShape2D2.shape.radius = 0
