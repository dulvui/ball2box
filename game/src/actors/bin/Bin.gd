# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends StaticBody

signal win

onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready():
	animation_player.play("Size")


func _on_BallDetector_body_entered(body) -> void:
	if body.is_in_group("ball"):
		$Timer.start()


func _on_Timer_timeout() -> void:
	emit_signal("win")


func fade_in() -> void:
	# to match arrow animation
	if Global.current_level > 1:
		animation_player.play("FadeIn")
		yield(animation_player,"animation_finished")
	animation_player.play("Size")


func hide() -> void:
	visible = false
	collision_layer = 0
	collision_mask = 0
	$BallDetector.monitoring = false


func show() -> void:
	visible = true
	collision_layer = 1
	collision_mask = 1
	$BallDetector.monitoring = true
