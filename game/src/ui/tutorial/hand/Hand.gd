# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Spatial

onready var timer:Timer = $Timer
onready var animation_player:AnimationPlayer = $AnimationPlayer

func swipe() -> void:
	visible = true
	animation_player.play("FadeInSwipe")

func tap() -> void:
	visible = true
	animation_player.stop()
	animation_player.play("FadeInTap")
	
func fade_out() -> void:
	visible = false


func _on_AnimationPlayer_animation_finished(anim_name:String) -> void:
	if anim_name == "FadeInTap":
		animation_player.play("Tap")
	elif anim_name == "FadeInSwipe":
		animation_player.play("Swipe")
