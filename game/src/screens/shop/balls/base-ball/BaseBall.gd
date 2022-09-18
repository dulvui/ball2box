extends Spatial


onready var animation_player = $AnimationPlayer

func _ready():
	if animation_player.has_animation("Rotate"):
		animation_player.play("Rotate")


func fade_in():
	animation_player.play("FadeIn")

func fade_out():
	animation_player.play("FadeOut")

func next():
	animation_player.play("FadeOut")
	yield(animation_player,"animation_finished")
	queue_free()
	
func prev():
	animation_player.play("FadeOut")
	yield(animation_player,"animation_finished")
	queue_free()
