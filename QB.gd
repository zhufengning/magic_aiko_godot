extends Area2D
signal died

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_QB_body_entered(body):
	$Health.value -= 2
	body.queue_free()
	if $Health.value <= 0:
		$Sprite.hide()
		$Health.hide()
		$Particles2D.emitting = true
		emit_signal("died")
		yield(get_tree().create_timer(3), "timeout")
