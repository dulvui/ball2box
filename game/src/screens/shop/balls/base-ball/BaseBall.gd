# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.com>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Spatial


onready var animation_player:AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if animation_player.has_animation("Rotate"):
		animation_player.play("Rotate")

func fade_in() -> void:
	animation_player.play("FadeIn")

func fade_out() -> void:
	animation_player.play("FadeOut")

func next() -> void:
	animation_player.play("FadeOut")
	yield(animation_player,"animation_finished")
	queue_free()
	
func prev() -> void:
	animation_player.play("FadeOut")
	yield(animation_player,"animation_finished")
	queue_free()
