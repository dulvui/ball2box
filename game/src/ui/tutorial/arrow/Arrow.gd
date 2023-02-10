extends Spatial

func size():
	$AnimationPlayer.play("Size")
	
func fade_out():
	$AnimationPlayer.play("FadeOut")
	yield($AnimationPlayer,"animation_finished")
	queue_free()
