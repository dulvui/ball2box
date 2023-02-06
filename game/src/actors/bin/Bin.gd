extends StaticBody

signal win

#func _ready():
#	$AnimationPlayer.play("Size")

func _on_BallDetector_body_entered(body):
	print("ball")
	if body.is_in_group("ball"):
		$Timer.start()


func _on_Timer_timeout():
	emit_signal("win")


func _on_BallDetector_body_exited(body):
#	if body.is_in_group("ball"):
#		$Timer.stop()
	pass
	
func fade_in():
	$AnimationPlayer.play("FadeIn")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("Size")
	
func hide():
	visible = false
	collision_layer = 0
	collision_mask = 0
	$BallDetector.monitoring = false
	
func show():
	visible = true
	collision_layer = 1
	collision_mask = 1
	$BallDetector.monitoring = true
