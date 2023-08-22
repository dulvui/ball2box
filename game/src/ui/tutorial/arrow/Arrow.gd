# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Spatial

func size() -> void:
	$AnimationPlayer.play("Size")
	
func fade_out() -> void:
	$AnimationPlayer.play("FadeOut")
	yield($AnimationPlayer,"animation_finished")
	queue_free()
