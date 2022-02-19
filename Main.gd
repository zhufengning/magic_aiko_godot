extends Node

export(PackedScene) var mob_scene
export(PackedScene) var bullet_scene
var score = 0
var mouse_ok = true
var bullet_speed = 500
var won = false

func _ready():
	randomize()
	new_game()
	
func _process(delta):
	if won:
		return
	$Path2D/PathFollow2D.offset += randi() % 500 * delta
	if $Player/Area2D.overlaps_body($TileMap):
		$Player/AnimatedSprite/hairl.process_material.gravity = Vector3(0, 5000, 0)
		$Player/AnimatedSprite/hairr.process_material.gravity = Vector3(0, 5000, 0)
	else:
		$Player/AnimatedSprite/hairl.process_material.gravity = Vector3(0, 100, 0)
		$Player/AnimatedSprite/hairr.process_material.gravity = Vector3(0, 100, 0)

	if mouse_ok and Input.is_action_pressed("click"):
		mouse_ok = false
		$MouseTimer.start()
		var nb = bullet_scene.instance()
		add_child(nb)
		var dire = (get_viewport().get_mouse_position() - $Player.position).normalized() * bullet_speed
		var pf
		if $Player/AnimatedSprite.flip_h:
			pf = -1
		else:
			pf = 1
		nb.position = $Player.position + Vector2(-4 * pf, 3)
		nb.linear_velocity = dire

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	Global.last_res = true
	get_tree().call_group("mobs", "queue_free")
	get_tree().change_scene("res://Start.tscn")
	Global.last_res = false

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$Path2D/PathFollow2D/QB/Health.value = 250



func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_MobTimer_timeout():
	# Create a Mob instance and add it to the scene.
	var mob = mob_scene.instance()
	add_child(mob)
	var loc = $Path2D/PathFollow2D.position + Vector2(0, 150)

	# Set the mob's direction perpendicular to the path direction.
	var direction = $Player.position - loc

	# Set the mob's position to a random location.
	mob.position = loc

	# Add some randomness to the direction.
	# direction = direction.rotated(rand_range(-PI / 16.0, PI / 16.0))
	mob.rotation = rand_range(-PI, PI)

	# Choose the velocity.
	var velocity = direction.normalized() * rand_range(150.0, 500.0)
	mob.linear_velocity = velocity
	

func _on_MouseTimer_timeout():
	mouse_ok = true

func _on_QB_died():
	won = true
	$Player/GreatTimer.stop()
	$Player.great = true
	$ScoreTimer.stop()
	$MobTimer.stop()
	get_tree().call_group("mobs", "queue_free")
	yield(get_tree().create_timer(3), "timeout")
	Global.last_res = true
	get_tree().change_scene("res://Start.tscn")
	
