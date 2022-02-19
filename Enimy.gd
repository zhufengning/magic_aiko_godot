# 我知道enemy打错了，懒得改了
extends RigidBody2D

var died = false
func _ready():
	$AnimationPlayer.play("shake")

# func _on_VisibilityNotifier2D_screen_exited():
# 	queue_free()


func _on_Enimy_body_entered(body):
	if "bullet" in body.get_groups():
		godie()

func godie():
	died = true
	print("qb die")
	$Particles2D.emitting = true
	$Node2D.visible = false
	linear_velocity *= 0
	angular_velocity *= 0
	collision_mask = 0
	collision_layer = 0
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()
