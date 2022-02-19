extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.last_res != null:
		if Global.last_res:
			$Label.text = "Good!!"
		else:
			$Label.text = "No!!!!"
		Global.last_res = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	$ChangeTimer.start()

func _on_ChangeTimer_timeout():
	get_tree().change_scene("res://Main.tscn")
