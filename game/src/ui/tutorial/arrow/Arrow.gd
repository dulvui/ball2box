extends Spatial

func size() -> void:
	$AnimationPlayer.play("Size")
	
func fade_out() -> void:
	$AnimationPlayer.play("FadeOut")
	yield($AnimationPlayer,"animation_finished")
	queue_free()
