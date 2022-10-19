extends Node2D

signal done
var swipe_done = false
var tap_done = false

func start():
	print("tutorial")
	$AnimationPlayer.play("Swipe")

func tap():
	$AnimationPlayer.play("Tap")
	
	
func _input(event):
	if event is InputEventScreenDrag:
		swipe_done = true
	elif event is InputEventScreenTouch and swipe_done:
		if tap_done:
			emit_signal("done")
			queue_free()
		if not event.pressed:
			$AnimationPlayer.play("TapFadeIn")
			$Text.text = "TAP"
			tap_done = true
	return false


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "TapFadeIn":
		$AnimationPlayer.play("Tap")
