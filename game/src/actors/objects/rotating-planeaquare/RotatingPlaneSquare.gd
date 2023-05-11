extends Spatial

onready var animation_player:AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("Idle")


func fade_in() -> void:
	animation_player.play("FadeIn")
	yield(animation_player,"animation_finished")
	animation_player.play("Rotate")
