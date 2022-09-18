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
