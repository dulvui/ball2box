extends Spatial

onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("Idle")


func fade_in():
	animation_player.play("FadeIn")
	yield(animation_player,"animation_finished")
	animation_player.play("Rotate")
