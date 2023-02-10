extends Spatial

# Called when the node enters the scene tree for the first time.
func swipe():
	$AnimationPlayer.play("FadeIn")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Swipe")
	
func tap():
	$AnimationPlayer.play("FadeIn")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Tap")
	
func fade_out():
	$AnimationPlayer.play("FadeOut")
	yield($AnimationPlayer,"animation_finished")
	queue_free()
