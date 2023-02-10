extends Spatial

onready var hand:Spatial = $Hand
onready var arrow:Spatial = $Arrow


func init() -> void:
	if Global.tutorial_tap_done:
		queue_free()
		return
	
	if Global.current_level > 1:
		arrow.queue_free()
		
	if Global.tutorial_swipe_done:
		hand.tap()
	
	arrow.size()
	
	if not Global.tutorial_swipe_done:
		hand.swipe()
		
func fade_out() -> void:
	hand.fade_out()
	arrow.fade_out()
	
	
func _input(event) -> void:
	if event is InputEventScreenDrag and not Global.tutorial_swipe_done:
		Global.tutorial_swipe_done = true
	elif event is InputEventScreenTouch and Global.tutorial_swipe_done:
		if not event.pressed:
			hand.tap()
#		elif $Hand.).a > 0:
#			$AnimationPlayer.play("HandFadeOut")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "TapFadeIn":
		$AnimationPlayer.play("Tap")
		Global.tutorial_tap_done = true
	elif anim_name == "FadeOut":
		queue_free()
