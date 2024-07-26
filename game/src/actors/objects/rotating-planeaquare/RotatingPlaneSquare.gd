# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node3D

@onready var animation_player:AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("Idle")


func fade_in() -> void:
	animation_player.play("FadeIn")
	await animation_player.animation_finished
	animation_player.play("Rotate")
