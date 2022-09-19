extends Control

func _ready():
	$AnimationPlayer.play("Go")

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().paused = true
	get_tree().change_scene("res://src/levels/Level%s.tscn"%str(Global.current_level))
