extends Spatial

onready var timer:Timer = $Timer
onready var animation_player:AnimationPlayer = $AnimationPlayer

func swipe():
	visible = true
	animation_player.play("FadeInSwipe")

func tap():
	visible = true
	animation_player.stop()
	animation_player.play("FadeInTap")
	
func fade_out():
	visible = false


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FadeInTap":
		animation_player.play("Tap")
	elif anim_name == "FadeInSwipe":
		animation_player.play("Swipe")
