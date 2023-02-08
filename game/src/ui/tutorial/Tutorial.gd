extends Node2D

func init():
	if Global.current_level > 1:
		$Arrow.hide()
	
	if not Global.tutorial_swipe_done:
		$AnimationPlayer.play("Swipe")
	elif not Global.tutorial_tap_done:
		$AnimationPlayer.play("Tap")
	else:
		queue_free()
		
func fade_out():
	$AnimationPlayer.play("FadeOut")
	
func _input(event):
	if event is InputEventScreenDrag and not Global.tutorial_swipe_done:
		Global.tutorial_swipe_done = true
		$AnimationPlayer.play("HandFadeOut")
	elif event is InputEventScreenTouch and Global.tutorial_swipe_done:
		if not event.pressed:
			$AnimationPlayer.play("TapFadeIn")
		elif $Hand.modulate.a > 0:
			$AnimationPlayer.play("HandFadeOut")
	return false


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "TapFadeIn":
		$AnimationPlayer.play("Tap")
		Global.tutorial_tap_done = true
	elif anim_name == "FadeOut":
		queue_free()
